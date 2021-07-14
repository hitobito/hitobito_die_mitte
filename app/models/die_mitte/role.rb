# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::Role
  extend ActiveSupport::Concern

  included do
    translates :label

    alias_method_chain :to_s, :merkmal
  end

  def to_s_with_merkmal(format=:default)
    model_name = self.class.label
    model_name = 'Merkmal' if self.class.sti_name.ends_with?('Merkmal')
    string = label? ? "#{model_name} (#{label})" : model_name
    if format == :long
      I18n.t('activerecord.attributes.role.string_long', role: string, group: group.to_s)
    else
      string
    end
  end

  class_methods do
    def label
      sti_name.ends_with?('Merkmal') ? 'Merkmal' : model_name.human
    end
  end
end
