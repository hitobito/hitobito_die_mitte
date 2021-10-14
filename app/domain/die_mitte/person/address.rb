# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::Person::Address

  private

  def combine_household_names(members)
    selected = Person::HouseholdSelector.new(members).select(2)
    return '' if selected.blank?

    if selected.count >= 2 && selected.first.last_name == selected.second.last_name
      I18n.t('people.address.two_with_same_last_name',
             first: selected.first.first_name,
             second: selected.second.first_name,
             last_name: selected.first.last_name)
    else
      selected.map(&:full_name).join("\n")
    end
  end
end
