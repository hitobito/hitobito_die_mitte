# frozen_string_literal: true

#  Copyright (c) 2022, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module Dropdown
  class InvoiceVariableDonationNew < InvoiceNew
    def path(finance_groups)
      super(finance_groups).merge(bla: :test)
    end
  end
end
