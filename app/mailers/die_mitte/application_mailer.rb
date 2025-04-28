# frozen_string_literal: true

#  Copyright (c) 2025, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::ApplicationMailer
  extend ActiveSupport::Concern

  prepended do
    private

    # Use correspondence_language instead of language attribute of person
    def resolve_email_language(person)
      person.correspondence_language || I18n.locale
    end
  end
end
