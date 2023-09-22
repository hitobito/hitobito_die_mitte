class MigrateGroupSettingsDieMitte < ActiveRecord::Migration[6.1]

  def up
    say_with_time('create group attributes') do
      add_column :groups, :letter_footer_column_1, :string
      add_column :groups, :letter_footer_column_2, :string
      add_column :groups, :letter_footer_column_3, :string
      add_column :groups, :letter_footer_column_4, :string

      Group.reset_column_information
    end

    return unless table_exists?(:settings)

    say_with_time('migrate group settings to group attributes') do
      migrate_settings
    end

    say_with_time('remove obsolete settings table') do
      if LegacyGroupSetting.count.zero?
        drop_table :settings
      end
    end

  end

  def down
    say_with_time('revert mounted attributes to group settings') do
      revert_mounted_attributes
    end

    say_with_time('remove group attributes') do
      remove_column :groups, :letter_footer_column_1
      remove_column :groups, :letter_footer_column_2
      remove_column :groups, :letter_footer_column_3
      remove_column :groups, :letter_footer_column_4
    end

    Group.reset_column_information
  end

  class LegacyGroupSetting < ActiveRecord::Base
    self.table_name = 'settings'
    belongs_to :target, polymorphic: true

    serialize :value, Hash
  end

  private

  def migrate_settings
    LegacyGroupSetting.where(target_type: 'Group').find_each do |setting|
      group = setting.target
      values = setting.value
      setting.value.each do |key, value|
        case key
        when 'footer_column_1'
          group.letter_footer_column_1 = values.delete(key)
        when 'footer_column_2'
          group.letter_footer_column_2 = values.delete(key)
        when 'footer_column_3'
          group.letter_footer_column_3 = values.delete(key)
        when 'footer_column_4'
          group.letter_footer_column_4 = values.delete(key)
        end
      end

      group.save!

      if values.empty?
        setting.destroy!
      else
        setting.save!
      end
    end
  end

  def revert_mounted_attributes
    create_settings_table
    relevant_group_ids = Group.where('letter_footer_column_1 IS NOT NULL OR ' \
                                     'letter_footer_column_2 IS NOT NULL OR ' \
                                     'letter_footer_column_3 IS NOT NULL OR ' \
                                     'letter_footer_column_4 IS NOT NULL').pluck(:id)

    Group.where(id: relevant_group_ids).find_each do |group|
      values_for_var = {
        messages_letter: {
          'footer_column_1' => group.letter_footer_column_1,
          'footer_column_2' => group.letter_footer_column_2,
          'footer_column_3' => group.letter_footer_column_3,
          'footer_column_4' => group.letter_footer_column_4
        }
      }

      values_for_var.each do |var, values|
        if values.values.any?(&:present?)
          setting = LegacyGroupSetting.find_or_create_by(target_type: 'Group',
                                                         target_id: group.id,
                                                         var: var)
          setting.value.merge!(values)

          setting.save!
        end
      end
    end
  end

  def create_settings_table
    return if table_exists?(:settings)

    create_table :settings do |t|
      t.string     :var, null: false
      t.text       :value
      t.references :target, null: false, polymorphic: true
      t.timestamps null: true
    end
    add_index :settings, [:target_type, :target_id, :var], unique: true

    LegacyGroupSetting.reset_column_information
  end
end
