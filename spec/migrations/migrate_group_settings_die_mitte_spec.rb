# frozen_string_literal: true

#  Copyright (c) 2023, Schweizer Alpen-Club. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

require 'spec_helper'
migration_file_name = File.expand_path('../../../db/migrate/20230919124243_migrate_group_settings_die_mitte.rb', __FILE__)
require migration_file_name

describe MigrateGroupSettingsDieMitte do
  before(:all) { self.use_transactional_tests = false }
  after(:all)  { self.use_transactional_tests = true }

  let(:migration) { described_class.new.tap { |m| m.verbose = false } }

  let(:layers) do
    [groups(:die_mitte), groups(:be)]
  end

  context '#up' do
    let(:group_settings) do
      layers.map do |group|
        MigrateGroupSettingsDieMitte::LegacyGroupSetting.create!({
          var: :messages_letter,
          target: group,
          value: {
            'footer_column_1' => 'bla',
            'footer_column_2' => 'bli',
            'footer_column_3' => 'blö',
            'footer_column_4' => 'ble'
          }
        })
      end
    end

    before do
      migration.down

      MigrateGroupSettingsDieMitte::LegacyGroupSetting.delete_all
    end

    it 'migrates group settings' do
      group_settings.each do |s|
        value = s.value['footer_column_3']

        expect(value).to be_present
        expect(value).to eq('blö')
      end

      expect do
        migration.up
      end.to change { MigrateGroupSettingsDieMitte::LegacyGroupSetting.count }.by(-2)

      layers.each do |group|
        group.reload
        expect(group.letter_footer_column_1).to eq('bla')
        expect(group.letter_footer_column_2).to eq('bli')
        expect(group.letter_footer_column_3).to eq('blö')
        expect(group.letter_footer_column_4).to eq('ble')
      end
    end
  end

  context '#down' do
    after do
      migration.up
      MigrateGroupSettingsDieMitte::LegacyGroupSetting.delete_all
    end

    it 'migrates regular settings' do
      layers.each do |group|
        group.update!(letter_footer_column_1: 'bla', 
                      letter_footer_column_2: 'bli',
                      letter_footer_column_3: 'blö',
                      letter_footer_column_4: 'ble')
      end

      expect do
        migration.down
      end.to change { MigrateGroupSettingsDieMitte::LegacyGroupSetting.count }.by(2)

      layers.each do |group|
        setting = MigrateGroupSettingsDieMitte::LegacyGroupSetting.find_by(target: group,
                                                                           var: :messages_letter)
        expect(setting.value['footer_column_1']).to eq('bla')
        expect(setting.value['footer_column_2']).to eq('bli')
        expect(setting.value['footer_column_3']).to eq('blö')
        expect(setting.value['footer_column_4']).to eq('ble')
      end
    end
  end
end
