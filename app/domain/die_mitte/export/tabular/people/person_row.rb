# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

module DieMitte
  module Export
    module Tabular
      module People
        module PersonRow
          extend ActiveSupport::Concern

          def salutation
            entry.salutation_value
          end

        end
      end
    end
  end
end
