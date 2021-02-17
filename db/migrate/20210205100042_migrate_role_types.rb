class MigrateRoleTypes < ActiveRecord::Migration[6.0]

  def change
    changes = [
      %W(Group::BundSekretariat::Generalsekretaer Group::BundSekretariat::Leitung),
      %W(Group::OrtGewaehlte::MitgliedWeitereKommissionen Group::OrtGewaehlte::MitgliedWeitereGemeindeKommissionen),
      %W(Group::OrtMitglieder::SympathisantNachKantonalemStatut Group::OrtMitglieder::Mitglied),
      %W(Group::KantonMitglieder::SympathisantNachKantonalemStatut Group::KantonMitglieder::Mitglied)
    ]
    reversible do |dir|
      dir.up { changes.each { |from, to| update_role_types(from, to) } }
      dir.down { changes.each { |to, from| update_role_types(from, to) } }
    end
  end

  def update_role_types(from, to)
    execute "UPDATE roles SET type = '#{to}' WHERE type = '#{from}'"
  end
end
