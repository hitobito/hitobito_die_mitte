# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::FilterNavigation::People
  def initialize(*args)
    super

    if group.layer?
      member_list = MemberList.new(group.layer_group, template.current_user)
      item(member_list.name, template.group_people_path(group), member_list.count)
    end
  end

  def visible_role_types?(types)
    group.layer? ? false : super
  end
end
