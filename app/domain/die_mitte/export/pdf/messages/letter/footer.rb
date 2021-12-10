# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte
  module Export
    module Pdf
      module Messages::Letter
        class Footer < ::Export::Pdf::Messages::Letter::Section
          COLUMNS = [115, 40].freeze

          def render(recipient)
            stamped :footer_columns
          end

          def footer_columns
            columns.each_with_index do |column, i|
              render_column(column, left: i * COLUMNS.first)
            end
          end

          def render_column(column, left: 0, width: COLUMNS.first, height: COLUMNS.second)
            bounding_box([left, 0], width: width, height: height) do
              text_box(column)
            end
          end

          def columns
            (1..4).map do |i|
              letter.group.settings(:messages_letter).send("footer_column_#{i}")
            end
          end
        end
      end
    end
  end
end
