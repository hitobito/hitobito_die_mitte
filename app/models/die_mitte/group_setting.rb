# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::GroupSetting
  extend ActiveSupport::Concern

  included do
    GroupSetting::SETTINGS.deep_merge!({
      messages_letter: { 
        footer_column_1: '',
        footer_column_2: '',
        footer_column_3: '',
        footer_column_4: '',
      }
    })
  end

end
