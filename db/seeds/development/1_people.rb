# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require Rails.root.join("db", "seeds", "support", "person_seeder")
require Rails.root.join("db", "seeds", "support", "person_duplicate_seeder")

class DieMittePersonSeeder < PersonSeeder
  def person_attributes(role_type)
    attrs = super

    attrs[:title] = ["", "", "", "", "", "", "", "", "Dr.", "Prof."].sample
    attrs[:website] = "example.com"
    attrs[:correspondence_language] = Settings.application.correspondence_languages.keys.sample.to_s
    attrs[:civil_status] = DieMitte::Person::CIVIL_STATUSES.sample
    attrs[:salutation] = Salutation.available.keys.sample
    attrs
  end

  def amount(role_type)
    case role_type.name.demodulize
    when "Member" then 3
    else 1
    end
  end

  def seed_printer
    attrs = {
      email: "info@sutergerteis.ch",
      company: true,
      company_name: "Suter & Gerteis AG",
      encrypted_password: encrypted_password
    }
    printer = Person.seed_once(attrs).first
    seed_role(printer, Group.root, Group::BundExterneKontakte::Kontakt)
  end
end

puzzlers = ["Pascal Zumkehr",
  "Andreas Maierhofer",
  "Matthias Viehweger",
  "Oli Brian",
  "Carlo Beltrame",
  "Mathis Hofer",
  "Pascal Simon"]

devs = {
  "Stefan Züger" => "stefan.zueger@die-mitte.ch",
  "Luca Strebel" => "luca.strebel@die-mitte.ch",
  "Pascal Bürgy" => "pascal.buergy@proact.ch"
}
puzzlers.each do |puz|
  devs[puz] = "#{puz.split.last.downcase}@puzzle.ch"
end

seeder = DieMittePersonSeeder.new

seeder.seed_printer

seeder.seed_all_roles

bund = Group::BundSekretariat.first
devs.each do |name, email|
  seeder.seed_developer(name, email, bund, Group::BundSekretariat::Mitarbeiter)
end

seeder.assign_role_to_root(bund, Group::BundSekretariat::Mitarbeiter)

5.times do
  PersonDuplicateSeeder.new.seed_duplicates
end
