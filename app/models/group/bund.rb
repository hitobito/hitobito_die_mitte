# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class Group::Bund < Group
  self.layer = true

  children Group::BundGewaehlte,
    Group::BundParteigremium,
    Group::BundPraesidium,
    Group::BundSekretariat,
    Group::BundKommission,
    Group::BundArbeitsgruppe,
    Group::BundExterneKontakte,
    Group::BundDelegierte,
    Group::BundMitglieder,
    Group::BundSympathisanten,
    Group::Kanton,
    Group::Vereinigung

  ### ROLES
  #
  self.default_children = [
    Group::BundGewaehlte,
    Group::BundSekretariat
  ]
end
