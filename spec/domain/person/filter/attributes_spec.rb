#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require "spec_helper"

describe Person::Filter::Attributes do
  let(:user)         { people(:sekretaer) }
  let(:group)        { groups(:die_mitte) }

  def filter(value)
    Person::Filter::List.new(
      group,
      user,
      range: 'deep',
      filters: {
        attributes: {
          '1234567890123': {
            key: key,
            constraint: 'match',
            value: value
          }
        }
      }
    )
  end

  context :correspondence_language do
    let(:key) { "correspondence_language" }

    it "finds three if blank" do
      expect(filter(nil).entries).to have(3).items
      expect(filter("").entries).to have(3).items
    end

    it "finds none if not matching" do
      expect(filter("invalid").entries).to be_empty
    end

    it "finds two with correspondence_language de" do
      expect(filter("de").entries).to have(2).items
      expect(filter("Deutsch").entries).to have(2).items
      expect(filter("Allemand").entries).to have(2).items
      expect(filter("allemand").entries).to have(2).items
    end

    it "finds one with correspondence_language en" do
      expect(filter("en").entries).to have(1).items
      expect(filter("inglese").entries).to have(1).items
    end
  end

end
