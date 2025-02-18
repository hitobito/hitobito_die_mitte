# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module Export::Tabular::Messages
  class LettersWithInvoice < Export::Tabular::Base
    INCLUDED_ATTRS = %w[esr_number recipient_email recipient_address reference total].freeze
    PERSON_ATTRS = %w[first_name last_name company_name company email address zip_code town country
      gender birthday salutation title correspondence_language household?].freeze
    HOUSEMATE_ATTRS = %w[first_name last_name salutation gender correspondence_language
      reference].freeze

    self.model_class = ::Invoice
    self.row_class = Export::Tabular::Messages::LettersWithInvoiceRow

    def build_attribute_labels
      invoice_attribute_labels
        .merge(person_attribute_labels)
        .merge(housemate_attribute_labels)
    end

    def invoice_attribute_labels
      attrs = INCLUDED_ATTRS.dup
      attrs << :donation_amount if message.donation_confirmation?
      attrs.collect(&:to_sym).index_with { |attr| attribute_label(attr) }
    end

    def person_attribute_labels
      PERSON_ATTRS.collect(&:to_sym).index_with { |attr| person_attribute(attr) }
    end

    def housemate_attribute_labels
      (2..largest_household_size).flat_map do |housemate_index|
        HOUSEMATE_ATTRS.map do |attr|
          [housemate_attr(attr, housemate_index), housemate_label(attr, housemate_index)]
        end
      end.to_h
    end

    def largest_household_size
      # If we have any households, the largest ones will be sorted to the beginning
      Array.wrap(list.first).count
    end

    def person_attribute(attr, options = {})
      Person.human_attribute_name(attr, options)
    end

    def housemate_attr(attr, housemate_index)
      :"#{attr}_#{housemate_index}"
    end

    def housemate_label(attr, housemate_index)
      I18n.t("export.tabular.messages.letters_with_invoice.housemate_n_attr",
        index: housemate_index,
        attr: person_attribute(attr, {default: attribute_label(attr)}))
    end

    private

    def message
      @message ||= Message::LetterWithInvoice.find_by(invoice_list: invoice_list)
    end

    def invoice_list
      @invoice_list ||= begin
        if list.respond_to?(:peek)
          list.peek
        else
          list.first
        end.first.invoice_list
      rescue StopIteration
        nil
      end
    end
  end
end
