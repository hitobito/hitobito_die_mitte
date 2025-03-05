# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require Rails.root.join('db', 'seeds', 'support', 'group_seeder')

seeder = GroupSeeder.new

bund = Group.roots.first
srand(42)

if bund.address.blank?
  bund.update(seeder.group_attributes)
  bund.default_children.each do |child_class|
    child_class.first.update(seeder.group_attributes)
  end
end

vereinigungen = Group::Vereinigung.seed(:name, :parent_id,
  {name: 'Die junge Mitte',
   short_name: 'Junge',
   parent_id: bund.id},

  {name: 'CVP Frauen',
   short_name: 'Frauen',
   parent_id: bund.id },
)

states = Group::Kanton.seed(:name, :parent_id,
  {name: 'Bern',
   short_name: 'BE',
   street: "Klostergasse",
   housenumber: 3,
   zip_code: "3333",
   town: "Bern",
   country: "CH",
   email: "bern@be.ch",
   parent_id: bund.id},

  {name: 'Zürich',
   short_name: 'ZH',
   street: "Tellgasse",
   housenumber: 3,
   zip_code: "8888",
   town: "Zürich",
   country: "CH",
   email: "zuerich@zh.ch",
   parent_id: bund.id },

  {name: 'Waadt',
   short_name: 'VD',
   street: "Nordostgasse",
   housenumber: 3,
   zip_code: "2000",
   town: "Lausanne",
   country: "CH",
   email: "vd@scout.ch",
   parent_id: bund.id },

  {name: 'Bern',
   short_name: 'BE',
   parent_id: vereinigungen[0].id},

  {name: 'Bern',
   short_name: 'BE',
   parent_id: vereinigungen[1].id},

)

states.each do |s|
  seeder.seed_social_accounts(s)
end

bezirke = Group::Region.seed(:name, :parent_id,
  {name: 'Stadt Bern',
   parent_id: states[0].id }.merge(seeder.group_attributes),

  {name: 'Emmental',
   parent_id: states[0].id }.merge(seeder.group_attributes),

  {name: 'Seeland',
   parent_id: states[0].id }.merge(seeder.group_attributes),

  {name: 'Stadt Zürich',
   parent_id: states[1].id }.merge(seeder.group_attributes)
)


bezirke.each do |r|
  seeder.seed_social_accounts(r)
end

Group::Ort.seed(:name, :parent_id,
  {name: 'Burgdorf',
   parent_id: bezirke[1].id }.merge(seeder.group_attributes),

  {name: 'Kirchberg',
   parent_id: bezirke[1].id }.merge(seeder.group_attributes),

  {name: 'Langnau',
   parent_id: bezirke[1].id }.merge(seeder.group_attributes),

  {name: 'Thun',
   parent_id: states[0].id }.merge(seeder.group_attributes),

  {name: 'Kirchenfeld',
   parent_id: bezirke[0].id }.merge(seeder.group_attributes),

  {name: 'Breitenrain',
   parent_id: bezirke[0].id }.merge(seeder.group_attributes),
)

Group.rebuild!
