# frozen_string_literal: true

#  Copyright (c) 2022, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'spec_helper'

describe DieMitte::Role do

  context 'merge people' do

    let!(:person) { Fabricate(:person) }
    let!(:duplicate) { Fabricate(:person_with_address_and_phone) }
    let(:actor) { people(:admin) }
    let(:person_roles) { person.roles.with_deleted }

    let(:merger) { People::Merger.new(@source.reload, @target.reload, actor) }

    before do
      Group::OrtMitglieder::Mitglied.create!(group: groups(:be_thun_mitglieder),
                                             person: duplicate)
    end

    it 'only merges label of currently selected language' do
      @source = duplicate
      @target = person

      duplicate.roles.first.update(label_de: 'Member_de',
                                   label_fr: 'Member_fr',
                                   label_it: 'Member_it')

      expect do
        merger.merge!
      end.to change(Person, :count).by(-1)

      person.reload
      expect(person.roles.count).to eq(1)
      expect(person.roles.first.label).to eq('Member_de')
      expect(person.roles.first.label_de).to eq('Member_de')
      expect(person.roles.first.label_it).to be_nil
      expect(person.roles.first.label_fr).to be_nil

      expect(Person.where(id: duplicate.id)).not_to exist

      log_hash = YAML.load(person.versions.first.object_changes)
      expect(log_hash[:roles].first).to eq('Mitglied (Member_de) (Thun / Mitglieder)')
    end
  end


end
