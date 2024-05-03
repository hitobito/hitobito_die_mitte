#  Copyright (c) 2021-2024, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'spec_helper'

describe Person::Address do

  let(:person) { people(:sekretaer) }
  let(:address) { Person::Address.new(person) }

  before do
    person.update(
        first_name: 'John',
        last_name: 'Doe',
        street: 'address',
        housenumber: '23',
        zip_code: '0000',
        town: 'towntown',
        household_key: 'my-test-household-key'
    )
  end

  it 'handles a single person' do
    expect(address.for_household_letter([person])).to eq "John Doe\naddress 23\n0000 towntown\n"
  end

  it 'handles two people with the same last name' do
    person2 = Fabricate(:person, first_name: 'Jane', last_name: person.last_name, household_key: person.household_key)

    expect(address.for_household_letter([person, person2])).to eq "John und Jane Doe\naddress 23\n0000 towntown\n"
  end

  it 'handles two people with different last name' do
    person2 = Fabricate(:person, first_name: 'Jane', last_name: 'Foo', household_key: person.household_key)

    expect(address.for_household_letter([person, person2])).to eq "John Doe\nJane Foo\naddress 23\n0000 towntown\n"
  end

  it 'prefers people with complete name' do
    person2 = Fabricate(:person, first_name: '', last_name: 'Bar', household_key: person.household_key)
    person3 = Fabricate(:person, first_name: 'Alanis', last_name: '', household_key: person.household_key)
    person4 = Fabricate(:person, first_name: 'Jane', last_name: 'Foo', household_key: person.household_key)

    expect(address.for_household_letter([person, person2, person3, person4])).to eq "John Doe\nJane Foo\naddress 23\n0000 towntown\n"
  end

  it 'prefers the most used last name' do
    person2 = Fabricate(:person, first_name: 'Jane', last_name: 'Foo', household_key: person.household_key)
    person3 = Fabricate(:person, first_name: 'Betty', last_name: 'Baz', household_key: person.household_key)
    person4 = Fabricate(:person, first_name: 'Charlotte', last_name: 'Baz', household_key: person.household_key)
    person5 = Fabricate(:person, first_name: 'Daniel', last_name: 'Baz', household_key: person.household_key)

    expect(address.for_household_letter([person, person2, person3, person4, person5])).to eq "Betty und Charlotte Baz\naddress 23\n0000 towntown\n"
  end

end
