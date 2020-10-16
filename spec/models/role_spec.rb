# encoding: utf-8

#  Copyright (c) 2012-2020, CVP Schweiz. This file is part of
#  hitobito_cvp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_cvp.

require 'spec_helper'

describe Role do
  let(:person) { people(:thuner) }

  context :assert_consistent_roles_within_mitglieder_group do
    context Group::Bund do
      let(:group)  { Fabricate(Group::BundMitglieder.name.to_sym, parent: groups(:cvp)) }

      it 'accepts multiple instances of same role for person' do
        role = Group::BundMitglieder::Mitglied.new(person: person, group: group)
        expect(role).to be_valid
      end

      it 'does not accept mixed role types' do
        Group::BundMitglieder::Mitglied.create!(person: person, group: group)
        role = Group::BundMitglieder::Sympathisant.new(person: person, group: group)
        expect(role).not_to be_valid
      end
    end

    context Group::Kanton do
      let(:group)  { Fabricate(Group::KantonMitglieder.name.to_sym, parent: groups(:be)) }

      it 'accepts multiple instances of same role for person' do
        role = Group::KantonMitglieder::Mitglied.new(person: person, group: group)
        expect(role).to be_valid
      end

      it 'does not accept mixed role types' do
        Group::KantonMitglieder::Mitglied.create!(person: person, group: group)
        role = Group::KantonMitglieder::SympathisantNachKantonalemStatut.new(person: person, group: group)
        expect(role).not_to be_valid
      end
    end

    context Group::Ort do
      let(:group)  { groups(:be_thun_mitglieder) }

      it 'accepts multiple instances of same role for person' do
        role = Group::OrtMitglieder::Mitglied.new(person: person, group: group)
        expect(role).to be_valid
      end

      it 'does not accept mixed role types' do
        role = Group::OrtMitglieder::SympathisantNachKantonalemStatut.new(person: person, group: group)
        expect(role).not_to be_valid
      end
    end
  end
end
