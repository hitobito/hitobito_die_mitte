# encoding: utf-8

#  Copyright (c) 2012-2020, CVP Schweiz. This file is part of
#  hitobito_cvp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_cvp.


require Rails.root.join('db', 'seeds', 'support', 'person_seeder')

class CvpPersonSeeder < PersonSeeder

  def person_attributes(role_type)
    attrs = super(role_type)

    attrs[:title] = %w(Herr Frau).sample
    attrs[:website] = "example.com"
    attrs[:correspondence_language] = Settings.application.correspondence_languages.keys.sample.to_s
    attrs[:civil_status] = Cvp::Person::CIVIL_STATUSES.sample
    attrs[:salutation] = Salutation.available.keys.sample
    attrs
  end

  def amount(role_type)
    case role_type.name.demodulize
    when 'Member' then 3
    else 1
    end
  end

end

puzzlers = ['Pascal Zumkehr',
            'Andreas Maierhofer',
            'Matthias Viehweger',
            'Oli Brian',
            'Carlo Beltrame',
            'Mathis Hofer',
            'Pascal Simon']

devs = {
  'Stefan Züger' => 'zueger@cvp.ch',
  'Luca Strebel' => 'strebel@cvp.ch',
  'Pascal Bürgy' => 'pascal.buergy@proact.ch'
}
puzzlers.each do |puz|
  devs[puz] = "#{puz.split.last.downcase}@puzzle.ch"
end

seeder = CvpPersonSeeder.new

seeder.seed_all_roles

bund = Group::BundSekretariat.first
devs.each do |name, email|
  seeder.seed_developer(name, email, bund, Group::BundSekretariat::Mitarbeiter)
end
