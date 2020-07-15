# encoding: utf-8

require Rails.root.join('db', 'seeds', 'support', 'person_seeder')

class CvpPersonSeeder < PersonSeeder

  def amount(role_type)
    case role_type.name.demodulize
    when 'Member' then 5
    else 1
    end
  end

end

puzzlers = ['Pascal Zumkehr',
            'Andreas Maierhofer',
            'Matthias Viehweger',
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

bund = Group.root
devs.each do |name, email|
  seeder.seed_developer(name, email, bund, Group::Bund::Leitung)
end
