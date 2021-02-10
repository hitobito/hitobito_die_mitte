# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.


class Group::Kanton < Group

  self.layer = true

  children Group::KantonGewaehlte,
           Group::KantonParteigremium,
           Group::KantonPraesidium,
           Group::KantonSekretariat,
           Group::KantonKommission,
           Group::KantonArbeitsgruppe,
           Group::KantonExterneKontakte,
           Group::KantonDelegierte,
           Group::KantonMitglieder,
           Group::KantonSympathisanten,

           Group::Region,
           Group::Ort


  # Group::Bezirk
  #
  self.default_children = [
    Group::KantonGewaehlte,
    Group::KantonSekretariat,
    Group::KantonMitglieder
  ]

end

