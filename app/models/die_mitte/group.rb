# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::Group
  extend ActiveSupport::Concern

  included do
    # Define additional used attributes
    self.used_attributes += [:letter_footer_column_1, :letter_footer_column_2,
      :letter_footer_column_3, :letter_footer_column_4]
    # self.superior_attributes = [:bank_account]

    root_types Group::Bund
  end
end
