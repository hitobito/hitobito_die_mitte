# frozen_string_literal: true

#  Copyright (c) 2023, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'spec_helper'

describe PersonReadables do

  [:index, :layer_search, :deep_search, :global].each do |action|
    context action do
      let(:action) { action }
      let(:role) { roles(:sekretaer) }
      let(:user)   { role.person.reload }
      let(:ability) { PersonReadables.new(user, action == :index ? role.group : nil) }
      let(:all_accessibles) do
        people = Person.accessible_by(ability)
        case action
        when :index then people
        when :layer_search then people.in_layer(group.layer_group)
        when :deep_search then people.in_or_below(group.layer_group)
        when :global then people
        end
      end

      subject { all_accessibles }

      it 'only registers one scope for accessible people' do
        rules = ability.send(:rules)

        expect(rules.size).to eq(1)
        rule = rules.first

        expect(rule.actions).to eq([:index])
      end
    end
  end
end
