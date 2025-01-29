class MigratePhoneNumberLabels < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      UPDATE phone_numbers SET label = 'Privat' WHERE label = 'Telefon Privat';
      UPDATE phone_numbers SET label = 'Arbeit' WHERE label = 'Telefon Geschäft';
      UPDATE phone_numbers SET label = 'Fax' WHERE label IN ('Fax Geschäft', 'Fax Privat');
      UPDATE phone_numbers SET label = 'Andere' WHERE label = 'Import';
    SQL
  end

  def down
    execute <<-SQL
      UPDATE phone_numbers SET label = 'Telefon Privat' WHERE label = 'Privat';
      UPDATE phone_numbers SET label = 'Telefon Geschäft' WHERE label = 'Arbeit';
      UPDATE phone_numbers SET label = 'Fax Privat' WHERE label = 'Fax'
      UPDATE phone_numbers SET label = 'Import' WHERE label = 'Andere';
    SQL
  end
end
