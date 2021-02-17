# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class Group::KantonPraesidium < Group

  class Praesident < Role
    self.permissions = [:contact_data]
  end

  class Vizepraesident < Role
    self.permissions = []
  end

  class Mitglied < Role
    self.permissions = []
  end

  class Gast < Role
    self.permissions = []
  end

  class Kassier < Role
    self.permissions = [:finance]
  end

  roles Praesident, Vizepraesident, Mitglied, Gast, Kassier
end
