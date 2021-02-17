# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class Group::BundArbeitsgruppe < Group::Simple

  class Praesident < Role; end
  class Leitung < Group::Simple::Leitung; end
  class Mitglied < Group::Simple::Mitglied; end
  class Gast < Role; end

  roles Praesident, Leitung, Mitglied, Gast

  children Group::BundArbeitsgruppe
end
