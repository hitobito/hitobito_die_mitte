#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'spec_helper'

describe Person::HouseholdSelector do

  it 'handles nil' do
    expect(described_class.new(nil).select).to eq []
  end

  it 'handles empty array' do
    expect(described_class.new([]).select).to eq []
  end

  it 'handles a single person' do
    people = [
        people(:sekretaer)
    ]
    expect(described_class.new(people).select).to eq people
  end

  it 'selects any two people' do
    people = [
        Fabricate(:person, last_name: 'Binder', first_name: 'Gregor'),
        Fabricate(:person, last_name: 'Gübeli', first_name: 'Alfred'),
        Fabricate(:person, last_name: 'Zuber', first_name: 'Tamara'),
    ]
    expect(described_class.new(people).select).to eq [people[0], people[1]]
  end

  it 'prefers people with complete name' do
    people = [
        Fabricate(:person, last_name: 'Binder', first_name: ''),
        Fabricate(:person, last_name: 'Gübeli', first_name: 'Alfred'),
        Fabricate(:person, last_name: 'Zuber', first_name: 'Tamara'),
    ]
    expect(described_class.new(people).select).to eq [people[1], people[2]]
  end

  it 'selects two people with the same last name' do
    people = [
        Fabricate(:person, last_name: 'Binder', first_name: 'Gregor'),
        Fabricate(:person, last_name: 'Gübeli', first_name: 'Alfred'),
        Fabricate(:person, last_name: 'Gübeli', first_name: 'Tamara'),
    ]
    expect(described_class.new(people).select).to eq [people[1], people[2]]
  end

  it 'ignores people with no full name when selecting same last name' do
    people = [
        Fabricate(:person, last_name: 'Binder', first_name: 'Gregor'),
        Fabricate(:person, last_name: 'Gübeli', first_name: 'Alfred'),
        Fabricate(:person, last_name: 'Gübeli', first_name: ''),
    ]
    expect(described_class.new(people).select).to eq [people[0], people[1]]
  end

  it 'prefers the most used last name' do
    people = [
        Fabricate(:person, last_name: 'Binder', first_name: 'Gregor'),
        Fabricate(:person, last_name: 'Gübeli', first_name: 'Alfred'),
        Fabricate(:person, last_name: 'Gübeli', first_name: 'Tamara'),
        Fabricate(:person, last_name: 'Baz', first_name: 'Betts'),
        Fabricate(:person, last_name: 'Baz', first_name: 'Charlotte'),
        Fabricate(:person, last_name: 'Baz', first_name: 'Daniel'),
    ]
    expect(described_class.new(people).select).to eq [people[3], people[4]]
  end

end
