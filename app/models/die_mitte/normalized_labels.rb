# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::NormalizedLabels
  def self.extended(base)
    # #normalize_label works only for the current locale. If we want this feature
    # for the die_mitte wagon, we need to implement the callback to normalize all
    # translations of the label field.
    base.skip_callback(:save, :before, :normalize_label)
  end

  def available_labels(lang = I18n.locale) = predefined_labels(lang)

  private

  def predefined_labels(_lang = I18n.locale) = []
end
