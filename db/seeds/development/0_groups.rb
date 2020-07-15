# encoding: utf-8

require Rails.root.join('db', 'seeds', 'support', 'group_seeder')

seeder = GroupSeeder.new

bund = Group.roots.first
srand(42)

if bund.address.blank?
  bund.update_attributes(seeder.group_attributes)
  bund.default_children.each do |child_class|
    child_class.first.update_attributes(seeder.group_attributes)
  end
end

vereinigungen = Group::Vereinigung.seed(:name, :parent_id,
  {name: 'Junge CVP',
   short_name: 'Junge',
   parent_id: bund.id},

  {name: 'CVP Frauen',
   short_name: 'Frauen',
   parent_id: bund.id },
)

states = Group::Kanton.seed(:name, :parent_id,
  {name: 'Bern',
   short_name: 'BE',
   address: "Klostergasse 3",
   zip_code: "3333",
   town: "Bern",
   country: "CH",
   email: "bern@be.ch",
   parent_id: bund.id},

  {name: 'Zürich',
   short_name: 'ZH',
   address: "Tellgasse 3",
   zip_code: "8888",
   town: "Zürich",
   country: "CH",
   email: "zuerich@zh.ch",
   parent_id: bund.id },

  {name: 'Waadt',
   short_name: 'VD',
   address: "Nordostgasse 3",
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




bezirke = Group::Bezirk.seed(:name, :parent_id,
  {name: 'Stadt Bern',
   parent_id: states[0].id }.merge(seeder.group_attributes),

  {name: 'Emmental',
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
)

Group.rebuild!
