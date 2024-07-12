# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class Group::VereinigungSekretariat < Group
  class Leitung < Role
    self.permissions = [:layer_and_below_full, :contact_data, :finance]
  end

  class Mitarbeiter < Role
    self.permissions = [:layer_and_below_full]
  end

  class Webadministrator < Role
    self.permissions = [:layer_and_below_full]
  end

  roles Leitung, Mitarbeiter, Webadministrator
end
