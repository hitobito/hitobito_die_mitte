# frozen_string_literal: true

#  Copyright (c) 2023, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::PersonReadables
  def initialize(user, group = nil, roles_join = nil)
    @user_context = AbilityDsl::UserContext.new(user)
    @roles_join = roles_join || {roles: :group}
    @group = group

    can :index, Person, accessible_people { |_| true }
  end
end
