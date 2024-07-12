# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class InvoiceItem::VariableDonation < InvoiceItem
  self.dynamic = true

  validates :cost, numericality: {greater_than: 0, allow_nil: true}

  def dynamic_cost
    return nil unless invoice&.recipient.present? || dynamic_cost_parameters[:recipient_id].present?

    layer = Group.find(dynamic_cost_parameters[:group_id]).layer_group
    invoice_config = layer.invoice_config

    return 0 unless invoice_config.variable_donation_configured?

    Payments::Collection.new
      .in_layer(layer)
      .in_last(invoice_config.donation_calculation_year_amount.years)
      .of_person(Person.find(dynamic_cost_parameters[:recipient_id]))
      .median_amount(increased_by: invoice_config.donation_increase_percentage)
  end
end
