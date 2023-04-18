# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class Group::BundSekretariat < Group

  class Leitung < Role
    self.permissions = [:layer_and_below_full, :contact_data, :admin, :finance, :complete_finance]
  end

  class Mitarbeiter < Role
    self.permissions = [:layer_and_below_full, :contact_data, :admin]
  end

  class ItSupport < Role
    self.permissions = [:layer_and_below_full, :contact_data, :admin, :impersonation, :complete_finance]
  end

  class Kassier < Role
    self.permissions = [:layer_and_below_full, :finance]
  end

  class Webadministrator < Role
    self.permissions = [:layer_and_below_full]
  end

  roles Leitung, Mitarbeiter, ItSupport, Kassier, Webadministrator
end
