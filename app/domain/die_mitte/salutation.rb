# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::Salutation
  def value_for_household(housemates)
    selected = Person::HouseholdSelector.new(housemates).select(2)
    selected.map { |housemate| Salutation.new(housemate, @salutation).value }.join("\n")
  end
end
