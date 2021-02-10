# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.



class Group::RegionGewaehlte < Group

  class Fraktionschef < Role; end
  class RegionExekutive < Role; end
  class RegionLegislative < Role; end
  class RegionJudikative < Role; end

  roles Fraktionschef,
        RegionExekutive,
        RegionLegislative,
        RegionJudikative


  children Group::RegionGewaehlte
end

