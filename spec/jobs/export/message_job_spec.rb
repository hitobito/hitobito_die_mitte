# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'spec_helper'

describe Export::MessageJob do

  subject { Export::MessageJob.new(format, user.id, message.id, { filename: 'message_export' }) }

  let(:user) { people(:sekretaer) }
  let(:person1) { create_person }
  let(:person2) { create_person }
  let(:person3) { create_person }
  let(:person4) { create_person }
  let(:top_layer) { groups(:sekretariat) }

  before do
    SeedFu.quiet = true
    SeedFu.seed [Rails.root.join('db', 'seeds')]
  end

  context 'creates a CSV-Export for letter with invoice' do
    let(:format) { :csv }

    let(:message) do
      Message::LetterWithInvoice
        .create!(mailing_list: mailing_lists(:list),
                 body: 'Lorem ipsum',
                 subject: 'A Sunny Day')
    end 

    before do
      create_invoice(person1)
      create_invoice(person2)
      create_invoice(person3)
      create_invoice(person4)
      invoices(:invoice).destroy!
      invoices(:sent).destroy!
      message.update!(invoice_list_id: message.invoice_list.id)
      person3.destroy! # invoices from this person should not be included anymore

      # Person 2 and 4 are in a household
      person4.update(household_key: 'asdf-asdf-asdf-asdf')
      person2.update(
          household_key: person4.household_key,
          address: person4.address,
          zip_code: person4.zip_code,
          town: person4.town
      )
    end

    it 'and saves it with combined households' do
      message.update!(donation_confirmation: false)

      subject.perform

      lines = subject.send(:async_download_file).read.lines
      expect(lines.size).to eq(9) # some addresses contain newlines
      expect(lines[0]).to match(Regexp.new("^#{Export::Csv::UTF8_BOM}Referenz Nummer;Empfänger E-Mail;Empfänger Adresse;Referenz;Rechnungsbetrag;Vorname;Nachname;Firmenname;Firma;Haupt-E-Mail;Adresse;PLZ;Ort;Land;Geschlecht;Geburtstag;Anrede;Titel;Korrespondenzsprache;Wohnt in einem Haushalt;Person 2 Vorname;Person 2 Nachname;Person 2 Anrede;Person 2 Geschlecht;Person 2 Korrespondenzsprache;Person 2 Referenz\n"))
      expect(lines[0].split(';').count).to match(26)
    end

    it 'and saves it with separate people for donation confirmation' do
      message.update!(donation_confirmation: true)

      subject.perform

      lines = subject.send(:async_download_file).read.lines
      expect(lines.size).to eq(13) # some addresses contain newlines
      expect(lines[0]).to match(Regexp.new("^#{Export::Csv::UTF8_BOM}Referenz Nummer;Empfänger E-Mail;Empfänger Adresse;Referenz;Rechnungsbetrag;Spendenbetrag;Vorname;Nachname;Firmenname;Firma;Haupt-E-Mail;Adresse;PLZ;Ort;Land;Geschlecht;Geburtstag;Anrede;Titel;Korrespondenzsprache;Wohnt in einem Haushalt\n"))
      expect(lines[0].split(';').count).to match(21)
    end
  end

  private

  def create_invoice(recipient)
    invoice = invoices(:sent).dup
    invoice.recipient = recipient
    invoice.invoice_list_id = message.invoice_list.id
    invoice.invoice_items << invoice_items(:pins).dup
    invoice.save!
    invoice
  end

  def create_person
    person = Fabricate(:person_with_address)
    Fabricate(Group::BundSekretariat::Mitarbeiter.name.to_sym, group: groups(:sekretariat), person: person)
    person
  end

end
