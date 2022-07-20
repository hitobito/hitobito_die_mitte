# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'spec_helper'

describe Export::Tabular::Messages::LettersWithInvoice do
  let(:invoice_list) { invoices.map { |i| [i] } }
  let(:top_layer) { groups(:die_mitte) }

  let(:letter_with_invoice_attributes) { 
    {
      mailing_list: mailing_lists(:leaders),
      group: top_layer,
      subject: 'Spendenaufruf',
      body: 'Bitte spenden',
      invoice_attributes: {
        invoice_items_attributes: {
          '1': {
            name: 'Spendenaufruf',
            count: 1,
            unit_cost: 0
          }
        }
      }
    }
  }

  subject { described_class.new(invoice_list) }

  context 'donation confirmation' do
    context 'active' do

      let!(:letter_with_invoice) { Message::LetterWithInvoice.create!(letter_with_invoice_attributes.merge(donation_confirmation: true)) }

      context 'used labels' do
        its(:attributes) do
          should == [:esr_number, :recipient_email, :recipient_address, :reference, :total, :donation_amount,
                     :first_name, :last_name, :company_name, :company, :email, :address,
                     :zip_code, :town, :country, :gender, :birthday, :salutation, :title,
                     :correspondence_language, :household?]
        end

        its(:labels) do
          should == ['Referenz Nummer', 'Empfänger E-Mail', 'Empfänger Adresse', 'Referenz',
                     'Rechnungsbetrag', 'Spendenbetrag', 'Vorname', 'Nachname', 'Firmenname', 'Firma',
                     'Haupt-E-Mail', 'Adresse', 'PLZ', 'Ort', 'Land', 'Geschlecht',
                     'Geburtstag', 'Anrede', 'Titel', 'Korrespondenzsprache', 'Wohnt in einem Haushalt']
        end
      end
      context 'inactive' do

      let!(:letter_with_invoice) { Message::LetterWithInvoice.create!(letter_with_invoice_attributes.merge(donation_confirmation: false)) }

        context 'used labels' do
          its(:attributes) do
            should == [:esr_number, :recipient_email, :recipient_address, :reference, :total,
                       :first_name, :last_name, :company_name, :company, :email, :address,
                       :zip_code, :town, :country, :gender, :birthday, :salutation, :title,
                       :correspondence_language, :household?]
          end

          its(:labels) do
            should == ['Referenz Nummer', 'Empfänger E-Mail', 'Empfänger Adresse', 'Referenz',
                       'Rechnungsbetrag', 'Vorname', 'Nachname', 'Firmenname', 'Firma',
                       'Haupt-E-Mail', 'Adresse', 'PLZ', 'Ort', 'Land', 'Geschlecht',
                       'Geburtstag', 'Anrede', 'Titel', 'Korrespondenzsprache', 'Wohnt in einem Haushalt']
          end
        end
      end
    end
  end
end
