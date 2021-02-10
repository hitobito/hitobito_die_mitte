# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class MemberList

  def initialize(layer_group, current_user)
    @layer_group = layer_group
    @current_user = current_user
  end

  def count
    Person::Filter::List.new(@layer_group,
                             @current_user,
                             filter_params).all_count
  end

  def name
    I18n.t('activerecord.attributes.role.class.kind.member.other')
  end

  def filter_params
    types = Role.all_types.select { |type| type < Role::Mitglied }
    ids = types.collect(&:id).join(Person::Filter::Base::ID_URL_SEPARATOR)
    {
      name: name,
      range: 'deep',
      filters: { role: { role_type_ids: ids } }
    }
  end

end
