# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module PeopleDieMitteHelper
  PERSON_I18N_KEY_PREFIX = "activerecord.attributes.person"

  def possible_person_civil_statuses
    DieMitte::Person::CIVIL_STATUSES.map do |key|
      [key, t("#{PERSON_I18N_KEY_PREFIX}.civil_statuses.#{key}")]
    end
  end

  def format_person_civil_status(person)
    t("#{PERSON_I18N_KEY_PREFIX}.civil_statuses.#{person.civil_status}")
  end
end
