# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class Group::VereinigungParteigremium < Group

  class Leitung < Role
    self.permissions = [:layer_and_below_full]
  end

  class Praesident < Role; end
  class Mitglied < Group::Simple::Mitglied; end
  class Gast < Role; end

  roles Praesident, Leitung, Mitglied, Gast

end
