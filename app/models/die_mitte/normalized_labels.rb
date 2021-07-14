# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::NormalizedLabels
  def available_labels(lang)
    Rails.cache.fetch(labels_cache_key(lang)) do
      load_available_labels(lang)
    end
  end

  def sweep_available_labels
    Settings.application.languages.keys.each do |key|
      Rails.cache.delete(labels_cache_key(key))
    end
  end

  private

  def load_available_labels(lang)
    predefined_labels(lang) |
      base_class.with_translations(lang).order(:label).distinct.pluck(:label).compact
  end

  def predefined_labels(_lang)
    []
  end

  def labels_cache_key(lang)
    "#{base_class.name}.Labels.#{lang}"
  end
end
