# encoding: utf-8

#  Copyright (c) 2021, CVP Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

module Cvp::Export::Pdf
  module Messages::Letter
    module Content

      def salutation(recipient)
        Salutation.new(recipient).value
      end

    end
  end
end
