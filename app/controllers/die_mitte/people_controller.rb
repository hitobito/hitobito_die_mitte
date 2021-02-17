# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::PeopleController
  extend ActiveSupport::Concern

  def self.prepended(base)
    base.permitted_attrs += [:title, :salutation, :website,
                             :correspondence_language, :civil_status]
  end

  def list_filter_args
    return super unless group.layer? && no_filter_active?

    MemberList.new(group, current_user).filter_params
  end

  def no_filter_active?
    %w(filters filter_id).none? { |k| params[k].present? }
  end
end
