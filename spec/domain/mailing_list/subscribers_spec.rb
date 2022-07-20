#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.
#
require "spec_helper"

describe MailingLists::Subscribers do
  let(:list) { mailing_lists(:list) }
  let(:group) { groups(:sekretariat) }

  context "correspondence_language" do
    let!(:other) do
      Fabricate(Group::BundSekretariat::Leitung.sti_name, group: group).person.tap do |person|
        person.update(correspondence_language: :de)
      end
    end

    it "includes two people if nil" do
      list.update(correspondence_language: nil)
      expect(list.people).to have(2).items
    end

    it "includes two people if blank" do
      list.update(correspondence_language: "")
      expect(list.people).to have(2).items
    end

    it "includes single perosn when set" do
      list.update(correspondence_language: :de)
      expect(list.people).to eq [other]
    end
  end
end
