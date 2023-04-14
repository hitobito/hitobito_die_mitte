# frozen_string_literal: true

#  Copyright (c) 2023, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::MailingListAbility
  extend ActiveSupport::Concern

  included do
    on(MailingList) do
      permission(:layer_and_below_full).may(:show, :index_subscriptions, :export_subscriptions)
        .in_same_layer_or_it_support
      permission(:layer_and_below_full).may(:create, :update, :destroy)
        .in_same_layer_if_active_or_it_support
    end
  end

  def in_same_layer_or_it_support
    in_same_layer || it_support?
  end

  def in_same_layer_if_active_or_it_support
    in_same_layer_if_active || it_support?
  end

  def it_support?
    user.roles
        .map(&:type)
        .include?(Group::BundSekretariat::ItSupport.sti_name)
  end
end
