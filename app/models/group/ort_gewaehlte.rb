# encoding: utf-8

#  Copyright (c) 2012-2020, CVP Schweiz. This file is part of
#  hitobito_cvp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_cvp.



class Group::OrtGewaehlte < Group

  class Fraktionschef < Role; end
  class KommunaleExekutive < Role; end
  class KommunaleLegislative < Role; end
  class Schulpflegekommission < Role; end
  class Rechnungspruefungskommission < Role; end
  class MitgliedWeitereKommissionen < Role; end

  roles Fraktionschef,
        KommunaleExekutive,
        KommunaleLegislative,
        Schulpflegekommission,
        Rechnungspruefungskommission,
        MitgliedWeitereKommissionen

  children Group::OrtGewaehlte
end
