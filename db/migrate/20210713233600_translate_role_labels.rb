class TranslateRoleLabels < ActiveRecord::Migration[6.0]
  def up
    say_with_time('creating translation table for roles') do
      Role.create_translation_table!({
        :label => :string
      }, {
        :migrate_data => false,
        :remove_source_columns => false
      })
    end

    I18n.with_locale(:fr) do
      say_with_time('migrate role-labels for french groups') do
        [
          158, 164, 174, 155, 159, 162, 176, 172,
          108, 37563, 98, 100, 119, 241, 38742, 38800, 36851, 255, 52966, 257
        ].each do |group_id|
          role_group_ids = Group.find(group_id).descendants.pluck(:id)

          next if role_group_ids.empty?

          say "migrating roles in #{role_group_ids.count} subgroups", true
          migrate_role_labels(I18n.locale, "group_id IN (#{role_group_ids.join(', ')})")
        end
      end
    end

    I18n.with_locale(:de) do
      say_with_time('migrate role-labels for german groups') do
        labeled_roles = Role
          .where("#{Role.quoted_table_name}.label IS NULL OR #{Role.quoted_table_name}.label = ''")

        total = (labeled_roles.count / 1000.0).ceil

        labeled_roles
          .select(:id)
          .in_batches
          .each_with_index do |role_batch, idx|
            say "migrating roles batch #{idx.succ} of #{total}", true
            migrate_role_labels(I18n.locale, "id IN (#{role_batch.map(&:id).join(', ')})")
          end
      end
    end

    remove_column(:roles, :label)
  end

  def down
    say_with_time('dropping translation-table for roles') do
      Role.drop_translation_table! :migrate_data => true
    end
  end

  private

  def migrate_role_labels(locale, condition)
    suppress_messages do
      execute <<~SQL.split.join(' ')
        INSERT INTO #{Role.translations_table_name}
               (locale, role_id, label, created_at, updated_at)
        SELECT '#{locale}' AS locale, id AS role_id, label,
               NOW() AS created_at, NOW() AS updated_at
        FROM roles
        WHERE (label != '' AND label IS NOT NULL)
        AND #{condition}
      SQL

      execute <<~SQL.split.join(' ')
        UPDATE #{Role.table_name}
        SET label = NULL
        WHERE #{condition}
      SQL
    end
  end
end
