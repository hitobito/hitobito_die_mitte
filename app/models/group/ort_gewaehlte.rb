# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.



class Group::OrtGewaehlte < Group

  class Fraktionschef < Role; end
  class KommunaleExekutive < Role; end
  class KommunaleLegislative < Role; end
  class Schulpflegekommission < Role; end
  class Rechnungspruefungskommission < Role; end
  class MitgliedWeitereGemeindeKommissionen < Role; end

  roles Fraktionschef,
        KommunaleExekutive,
        KommunaleLegislative,
        Schulpflegekommission,
        Rechnungspruefungskommission,
        MitgliedWeitereGemeindeKommissionen

  children Group::OrtGewaehlte
end
