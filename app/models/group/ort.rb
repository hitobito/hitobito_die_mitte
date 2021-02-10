# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class Group::Ort < Group

  self.layer = true

  children Group::OrtGewaehlte,
           Group::OrtParteigremium,
           Group::OrtPraesidium,
           Group::OrtSekretariat,
           Group::OrtArbeitsgruppe,
           Group::OrtExterneKontakte,
           Group::OrtMitglieder,
           Group::OrtSympathisanten

  self.default_children = [
    Group::OrtGewaehlte,
    Group::OrtSekretariat,
    Group::OrtMitglieder
  ]

end

