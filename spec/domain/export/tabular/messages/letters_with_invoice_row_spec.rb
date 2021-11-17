# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'spec_helper'

describe Export::Tabular::Messages::LettersWithInvoiceRow do
  let(:top_layer) { groups(:die_mitte) }
  let(:top_leader) { people(:sekretaer) }
  let(:bottom_member) { people(:thuner) }
  let(:invoice) { Fabricate(:invoice, due_at: 10.days.from_now, creator: top_leader,
                            recipient: bottom_member, group: top_layer, ) }

  subject { described_class.new(invoice) }

  context 'invoice attributes' do
    it 'are present' do
      expect(subject.fetch(:esr_number)).to eq(invoice.esr_number)
      expect(subject.fetch(:recipient_email)).to eq(invoice.recipient_email)
      expect(subject.fetch(:recipient_address)).to eq(invoice.recipient_address)
      expect(subject.fetch(:reference)).to eq(invoice.reference)
      expect(subject.fetch(:total)).to eq(invoice.total)
    end
  end

  context 'recipient attributes' do
    it 'are present' do
      expect(subject.fetch(:first_name)).to eq(bottom_member.first_name)
      expect(subject.fetch(:last_name)).to eq(bottom_member.last_name)
      expect(subject.fetch(:company_name)).to eq(bottom_member.company_name)
      expect(subject.fetch(:company)).to eq('nein')
      expect(subject.fetch(:email)).to eq(bottom_member.email)
      expect(subject.fetch(:address)).to eq(bottom_member.address)
      expect(subject.fetch(:zip_code)).to eq(bottom_member.zip_code)
      expect(subject.fetch(:town)).to eq(bottom_member.town)
      expect(subject.fetch(:country)).to eq(bottom_member.country)
      expect(subject.fetch(:gender)).to eq(bottom_member.gender)
      expect(subject.fetch(:birthday)).to eq(bottom_member.birthday)
      expect(subject.fetch(:salutation)).to eq('Liebe*r A')
      expect(subject.fetch(:title)).to eq('Herr')
      expect(subject.fetch(:correspondence_language)).to eq('de')
      expect(subject.fetch(:household?)).to eq('nein')
    end
  end

  context 'households' do
    let(:bottom_member2) { people(:zuercher) }
    let(:invoice2) { Fabricate(:invoice, due_at: 10.days.from_now, creator: top_leader,
                               recipient: bottom_member2, group: top_layer, ) }
    subject { described_class.new([invoice, invoice2]) }

    it 'are output as additional columns' do
      expect(subject.fetch(:first_name)).to eq(bottom_member.first_name)
      expect(subject.fetch(:last_name)).to eq(bottom_member.last_name)
      expect(subject.fetch(:company_name)).to eq(bottom_member.company_name)
      expect(subject.fetch(:company)).to eq('nein')
      expect(subject.fetch(:email)).to eq(bottom_member.email)
      expect(subject.fetch(:address)).to eq(bottom_member.address)
      expect(subject.fetch(:zip_code)).to eq(bottom_member.zip_code)
      expect(subject.fetch(:town)).to eq(bottom_member.town)
      expect(subject.fetch(:country)).to eq(bottom_member.country)
      expect(subject.fetch(:gender)).to eq(bottom_member.gender)
      expect(subject.fetch(:birthday)).to eq(bottom_member.birthday)
      expect(subject.fetch(:salutation)).to eq('Liebe*r A')
      expect(subject.fetch(:title)).to eq('Herr')
      expect(subject.fetch(:correspondence_language)).to eq('de')
      expect(subject.fetch(:household?)).to eq('nein')
      expect(subject.fetch(:first_name_2)).to eq(bottom_member2.first_name)
      expect(subject.fetch(:last_name_2)).to eq(bottom_member2.last_name)
      expect(subject.fetch(:salutation_2)).to eq('Liebe*r Frau*Herr Herr Zuercher')
      expect(subject.fetch(:gender_2)).to eq(bottom_member2.gender)
      expect(subject.fetch(:correspondence_language_2)).to eq('de')
      expect(subject.fetch(:reference_2)).to eq(invoice2.reference)
    end

    it 'which are smaller leave the added columns empty' do
      expect(subject.fetch(:first_name_3)).to be_nil
      expect(subject.fetch(:last_name_3)).to be_nil
      expect(subject.fetch(:salutation_3)).to be_nil
      expect(subject.fetch(:gender_3)).to be_nil
      expect(subject.fetch(:correspondence_language_3)).to be_nil
      expect(subject.fetch(:reference_3)).to be_nil
    end
  end
end
