# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'globalize-accessors'

module DieMitte::Role
  extend ActiveSupport::Concern

  included do
    translates :label
    globalize_accessors locales: Settings.application.languages.keys,
                        attributes: [:label]

    self.used_attributes += globalize_attribute_names

    self.merge_excluded_attributes = globalize_attribute_names

    alias_method_chain :to_s, :merkmal
  end

  def to_s_with_merkmal(format = :default)
    model_name = self.class.label
    model_name = 'Merkmal' if self.class.sti_name.ends_with?('Merkmal')

    unless format == :short
      model_name = label? ? "#{model_name} (#{label})" : model_name
      model_name += " (#{formatted_delete_date})" if delete_on
    end
    if format == :long
      I18n.t('activerecord.attributes.role.string_long', role: model_name, group: group.to_s)
    else
      model_name
    end
  end

  class_methods do
    def label
      sti_name.ends_with?('Merkmal') ? 'Merkmal' : model_name.human
    end
  end
end
