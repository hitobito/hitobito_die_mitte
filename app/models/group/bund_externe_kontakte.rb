# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class Group::BundExterneKontakte < Group

  class Medien < Role
    self.permissions = []
  end

  class Spender < Role
    self.permissions = []
  end

  class Kontakt < Role
    self.permissions = []
  end

  roles Medien, Spender, Kontakt

  children Group::BundExterneKontakte
end
