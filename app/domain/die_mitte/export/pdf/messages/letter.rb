# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte
  module Export
    module Pdf
      module Messages::Letter
        extend ActiveSupport::Concern

        included do
          def sections
            @sections ||= [::Export::Pdf::Messages::Letter::Header,
              ::Export::Pdf::Messages::Letter::Content,
              Footer].collect do |section|
              section.new(pdf, @letter, @options.slice(:debug, :stamped))
            end
          end
        end
      end
    end
  end
end
