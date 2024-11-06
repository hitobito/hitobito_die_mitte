# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require "spec_helper"

describe SearchStrategies::PersonSearch do
  describe "#search_fulltext" do
    let(:user) { people(:admin) }

    it "finds accessible person by title" do
      result = search_class(people(:admin).title.to_s).search_fulltext

      expect(result).to include(people(:admin))
    end

    it "finds accessible person by website" do
      result = search_class(people(:admin).website.to_s).search_fulltext

      expect(result).to include(people(:admin))
    end

    it "finds accessible person by correspondence_language" do
      result = search_class(people(:admin).correspondence_language.to_s).search_fulltext

      expect(result).to include(people(:admin))
    end

    it "finds accessible person by civil_status" do
      result = search_class(people(:admin).civil_status.to_s).search_fulltext

      expect(result).to include(people(:admin))
    end

    it "finds accessible person by salutation" do
      result = search_class(people(:admin).salutation.to_s).search_fulltext

      expect(result).to include(people(:admin))
    end
  end

  def search_class(term = nil, page = nil)
    described_class.new(user, term, page)
  end
end
