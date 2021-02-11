# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class Group::KantonKommission < Group::Simple

  class Praesident < Role
    self.permissions = []
  end

  class Leitung < Simple::Leitung
  end

  class Mitglied < Simple::Mitglied
  end

  roles Praesident, Leitung, Mitglied

  children Group::KantonKommission
end
