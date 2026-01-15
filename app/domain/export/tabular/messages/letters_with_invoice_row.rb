# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

module Export::Tabular::Messages
  class LettersWithInvoiceRow < Export::Tabular::People::HouseholdRow
    self.dynamic_attributes = LettersWithInvoice::HOUSEMATE_ATTRS
      .each_with_object({}) do |attr, dynamic_attributes|
      dynamic_attributes[Regexp.new("^#{attr}_(\\d+)$")] = attr.to_sym
    end

    private

    def first_name(attr = nil)
      housemate(attr)&.first_name
    end

    def last_name(attr = nil)
      housemate(attr)&.last_name
    end

    def company_name(attr = nil)
      housemate(attr)&.company_name
    end

    def company(attr = nil)
      housemate(attr)&.company
    end

    def email(attr = nil)
      housemate(attr)&.email
    end

    def address(attr = nil)
      housemate(attr)&.address
    end

    def zip_code(attr = nil)
      housemate(attr)&.zip_code
    end

    def town(attr = nil)
      housemate(attr)&.town
    end

    def country(attr = nil)
      housemate(attr)&.country
    end

    def gender(attr = nil)
      housemate(attr)&.gender
    end

    def birthday(attr = nil)
      housemate(attr)&.birthday
    end

    def salutation(attr = nil)
      return nil if housemate(attr).nil?

      Salutation.new(housemate(attr), message&.salutation).value
    end

    def title(attr = nil)
      housemate(attr)&.title
    end

    def language(attr = nil)
      housemate(attr)&.language
    end

    def household?(attr = nil)
      housemate(attr)&.household_key?
    end

    def reference(attr = nil)
      return nil if housemate(attr).nil?

      household[index_for(attr)]&.reference
    end

    def recipient_address(attr = nil)
      invoice = household[index_for(attr)]
      if invoice.recipient_address_values.empty?
        invoice.deprecated_recipient_address
      else
        invoice.recipient_address_values.join("\n")
      end
    end

    def donation_amount
      return nil unless message.donation_confirmation?

      amount = ::Payments::Collection.new
        .in_last(1.year)
        .in_layer(entry.group)
        .of_person(entry.recipient)
        .payments_amount
        .to_s

      sprintf("%.2f", amount)
    end

    def message
      @message ||= Message::LetterWithInvoice.find_by(invoice_run: entry.invoice_run)
    end

    private

    def index_for(attr)
      Integer(attr.to_s.match(/_(\d+)$/)&.[](1).presence || 1) - 1
    end

    def housemate(attr = nil)
      index = index_for attr
      return nil unless household.count > index
      household[index]&.recipient
    end
  end
end
