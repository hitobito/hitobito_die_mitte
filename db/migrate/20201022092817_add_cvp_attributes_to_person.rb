class AddCvpAttributesToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :title, :string, null: true
    add_column :people, :website, :string, null: true
    add_column :people, :salutation, :string, null: true
    add_column :people, :correspondence_language, :string, null: false, default: 'de'
    add_column :people, :civil_status, :string, null: false, default: 'single'
    Person.reset_column_information
  end
end
