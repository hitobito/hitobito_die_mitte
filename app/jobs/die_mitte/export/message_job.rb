# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::Export::MessageJob
  # This statement is required because these classes would not be loaded correctly otherwise.
  # The price we pay for using classes as namespace.
  require_dependency 'message/letter'
  require_dependency 'message/letter_with_invoice'
  require_dependency 'subscription'

  extend ActiveSupport::Concern

  private

  def recipients
    @recipients ||= message.send_to_households? || message.is_a?(Message::LetterWithInvoice) ?
                        People::HouseholdList.new(message.recipients).each :
                        message.message_recipients
  end

  def recipient_invoices
    @recipient_invoices ||= recipients.lazy.map do |person_or_household|
      Array.wrap(person_or_household).map do |person|
        invoice_list.invoices.find_or_initialize_by(recipient_id: person.id)
      end
    end
  end

  def invoice_list
    @invoice_list ||= InvoiceList.find(message.invoice_list_id)
  end

  def data
    case @format
    when :csv
      case message
      when Message::LetterWithInvoice
        Export::Tabular::Messages::LettersWithInvoice.export(@format, recipient_invoices)
      else
        Export::Tabular::Messages::Letters.export(@format, recipients)
      end
    else
      super
    end
  end

end
