# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class Group::BundGewaehlte < Group
  class Bundesrat < Role; end

  class Bundeskanzler < Role; end

  class Staenderat < Role; end

  class Nationalrat < Role; end

  class VollamtBundesrichter < Role; end

  class NebenamtBundesRichter < Role; end

  class Bundesverwaltungsrichter < Role; end

  class Bundespatentrichter < Role; end

  class Bundesstrafrichter < Role; end

  roles Bundesrat,
    Bundeskanzler,
    Staenderat,
    Nationalrat,
    VollamtBundesrichter,
    NebenamtBundesRichter,
    Bundesverwaltungsrichter,
    Bundespatentrichter,
    Bundesstrafrichter

  children Group::BundGewaehlte
end
