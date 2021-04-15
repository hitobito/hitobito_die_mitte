# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class Group::OrtSekretariat < Group

  class Leitung < Role
    self.permissions = [:layer_full, :contact_data, :finance]
  end

  class Mitarbeiter < Role
    self.permissions = [:layer_full]
  end

  class Webadministrator < Role; end

  roles Leitung, Mitarbeiter, Webadministrator
end
