# frozen_string_literal: true

#  Copyright (c) 2021-2024, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require "spec_helper"

describe SearchStrategies::PersonSearch do
  describe "#search_fulltext" do
    let(:user) { people(:admin) }

    it "finds accessible person by role-label" do
      search_term = 'Admingott'

      user.roles << Group::BundSekretariat::ItSupport.new(group: groups(:sekretariat), label: search_term)
      result = search_class(search_term).search_fulltext

      expect(result).to include(people(:admin))
    end
  end

  def search_class(term = nil, page = nil)
    described_class.new(user, term, page)
  end
end
