# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::RoleDecorator

  def for_aside
    tags = [super]

    if model.group.type.ends_with?('Mitglieder')
      hierarchy = (model.group.layer_hierarchy - [model.group.layer_group])
      tags += hierarchy.collect do |group|
        link = h.link_to(h.sanitize(group.to_s), group)
        label = "#{model.model_name.human} - #{group.model_name.human} #{link}"
        content_tag(:strong, label.html_safe)
      end.reverse
    end
    safe_join(tags, h.tag(:br))
  end
end
