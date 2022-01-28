# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module Export::Tabular::Messages
  class LettersWithInvoice < Export::Tabular::Base
    INCLUDED_ATTRS = %w(esr_number recipient_email recipient_address
                        reference total donation_amount).freeze
    PERSON_ATTRS = %w(first_name last_name company_name company email address zip_code town country
                      gender birthday salutation title correspondence_language household?).freeze
    HOUSEMATE_ATTRS = %w(first_name last_name salutation gender correspondence_language
                         reference).freeze

    self.model_class = ::Invoice
    self.row_class = Export::Tabular::Messages::LettersWithInvoiceRow

    def build_attribute_labels
      invoice_attribute_labels.
          merge(person_attribute_labels).
          merge(housemate_attribute_labels)
    end

    def invoice_attribute_labels
      INCLUDED_ATTRS.collect(&:to_sym).index_with { |attr| attribute_label(attr) }
    end

    def person_attribute_labels
      PERSON_ATTRS.collect(&:to_sym).index_with { |attr| person_attribute(attr) }
    end

    def housemate_attribute_labels
      (2..largest_household_size).map do |housemate_index|
        HOUSEMATE_ATTRS.map do |attr|
          [housemate_attr(attr, housemate_index), housemate_label(attr, housemate_index)]
        end
      end.flatten(1).to_h
    end

    def largest_household_size
      # If we have any households, the largest ones will be sorted to the beginning
      Array.wrap(list.first).count
    end

    def person_attribute(attr, options = {})
      Person.human_attribute_name(attr, options)
    end

    def housemate_attr(attr, housemate_index)
      "#{attr}_#{housemate_index}".to_sym
    end

    def housemate_label(attr, housemate_index)
      I18n.t('export.tabular.messages.letters_with_invoice.housemate_n_attr', {
          index: housemate_index,
          attr: person_attribute(attr, { default: attribute_label(attr)})
      })
    end
  end
end
