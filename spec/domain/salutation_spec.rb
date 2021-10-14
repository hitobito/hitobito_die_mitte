#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'spec_helper'

describe Salutation do

  let(:person) { people(:sekretaer) }

  before do
    person.update(
        first_name: 'John',
        last_name: 'Doe',
        salutation: :sehr_geehrter_titel_nachname
    )
  end

  context 'using personal salutation' do

    let(:subject) { Salutation.new(person, 'personal') }

    it 'handles a single person' do
      expect(subject.value_for_household([person])).to eq "Sehr geehrte*r Frau*Herr Herr Doe"
    end

    it 'handles two people with the same last name' do
      person2 = Fabricate(:person, first_name: 'Jane', last_name: person.last_name, salutation: :lieber_vorname)

      expect(subject.value_for_household([person, person2])).to eq "Sehr geehrte*r Frau*Herr Herr Doe\nLiebe*r Jane"
    end

    it 'handles two people with different last name' do
      person2 = Fabricate(:person, first_name: 'Jane', last_name: 'Foo', salutation: :lieber_vorname)

      expect(subject.value_for_household([person, person2])).to eq "Sehr geehrte*r Frau*Herr Herr Doe\nLiebe*r Jane"
    end

    it 'prefers people with complete name' do
      person2 = Fabricate(:person, first_name: '', last_name: 'Bar', salutation: :lieber_vorname)
      person3 = Fabricate(:person, first_name: 'Alanis', last_name: '', salutation: :lieber_titel_nachname)
      person4 = Fabricate(:person, first_name: 'Jane', last_name: 'Foo', salutation: :lieber_titel_nachname)

      expect(subject.value_for_household([person, person2, person3, person4])).to eq "Sehr geehrte*r Frau*Herr Herr Doe\nLiebe*r Frau*Herr Foo"
    end

    it 'prefers the most used last name' do
      person2 = Fabricate(:person, first_name: 'Jane', last_name: 'Foo', salutation: :lieber_vorname)
      person3 = Fabricate(:person, first_name: 'Betty', last_name: 'Baz', salutation: :lieber_vorname)
      person4 = Fabricate(:person, first_name: 'Charlotte', last_name: 'Baz', salutation: :lieber_titel_nachname)
      person5 = Fabricate(:person, first_name: 'Daniel', last_name: 'Baz', salutation: :lieber_titel_nachname)

      expect(subject.value_for_household([person, person2, person3, person4, person5])).to eq "Liebe*r Betty\nLiebe*r Frau*Herr Baz"
    end

  end

  context 'when given letter salutation' do

    let(:subject) { Salutation.new(person, :lieber_titel_nachname) }

    it 'handles a single person' do
      expect(subject.value_for_household([person])).to eq "Liebe*r Frau*Herr Herr Doe"
    end

    it 'handles two people with the same last name' do
      person2 = Fabricate(:person, first_name: 'Jane', last_name: person.last_name, salutation: :lieber_vorname)

      expect(subject.value_for_household([person, person2])).to eq "Liebe*r Frau*Herr Herr Doe\nLiebe*r Frau*Herr Doe"
    end

    it 'handles two people with different last name' do
      person2 = Fabricate(:person, first_name: 'Jane', last_name: 'Foo', salutation: :lieber_vorname)

      expect(subject.value_for_household([person, person2])).to eq "Liebe*r Frau*Herr Herr Doe\nLiebe*r Frau*Herr Foo"
    end

    it 'prefers people with complete name' do
      person2 = Fabricate(:person, first_name: '', last_name: 'Bar', salutation: :lieber_vorname)
      person3 = Fabricate(:person, first_name: 'Alanis', last_name: '', salutation: :lieber_titel_nachname)
      person4 = Fabricate(:person, first_name: 'Jane', last_name: 'Foo', salutation: :lieber_titel_nachname)

      expect(subject.value_for_household([person, person2, person3, person4])).to eq "Liebe*r Frau*Herr Herr Doe\nLiebe*r Frau*Herr Foo"
    end

    it 'prefers the most used last name' do
      person2 = Fabricate(:person, first_name: 'Jane', last_name: 'Foo', salutation: :lieber_vorname)
      person3 = Fabricate(:person, first_name: 'Betty', last_name: 'Baz', salutation: :lieber_vorname)
      person4 = Fabricate(:person, first_name: 'Charlotte', last_name: 'Baz', salutation: :lieber_titel_nachname)
      person5 = Fabricate(:person, first_name: 'Daniel', last_name: 'Baz', salutation: :lieber_titel_nachname)

      expect(subject.value_for_household([person, person2, person3, person4, person5])).to eq "Liebe*r Frau*Herr Baz\nLiebe*r Frau*Herr Baz"
    end

  end

end
