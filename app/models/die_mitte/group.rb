# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::Group
  extend ActiveSupport::Concern

  included do
    # Define additional used attributes
    # self.used_attributes += [:website, :bank_account, :description]
    # self.superior_attributes = [:bank_account]

    self.mounted_attr_categories = {
      messages: [:letter_address_position,
                 :letter_logo,
                 :letter_footer_column_1,
                 :letter_footer_column_2,
                 :letter_footer_column_3,
                 :letter_footer_column_4,
                 :text_message_username,
                 :text_message_password,
                 :text_message_provider,
                 :text_message_originator]
    }


    mounted_attr :letter_footer_column_1, :text
    mounted_attr :letter_footer_column_2, :text
    mounted_attr :letter_footer_column_3, :text
    mounted_attr :letter_footer_column_4, :text

    root_types Group::Bund
  end

end
