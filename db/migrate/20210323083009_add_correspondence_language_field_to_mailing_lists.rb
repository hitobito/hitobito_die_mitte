#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class AddCorrespondenceLanguageFieldToMailingLists < ActiveRecord::Migration[6.0]
  def change
    change_table :mailing_lists do |t|
      t.string :correspondence_language
    end
  end
end
