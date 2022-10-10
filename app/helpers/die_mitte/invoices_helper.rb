# frozen_string_literal: true

#  Copyright (c) 2022, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::InvoicesHelper

  def invoice_variable_donation_button(people: [], mailing_list: nil, filter: nil, group: nil)
    Dropdown::InvoiceNew.new(self, {
      people: people,
      mailing_list: mailing_list,
      group: group,
      filter: filter,
      invoice_items: [InvoiceItem::VariableDonation.sti_name],
      label: t('.new_variable_donation'), 
    }).button_or_dropdown
  end

end
