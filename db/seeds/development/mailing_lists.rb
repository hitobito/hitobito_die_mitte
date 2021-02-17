# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require Rails.root.join('db', 'seeds', 'support', 'mailing_list_seeder')

seeder = MailingListSeeder.new

Group.all.pluck(:id).each do |group_id|
  rand(3).times do
    seeder.seed_mailing_list(group_id)
  end
end
