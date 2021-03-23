#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module MailingListDieMitteHelper
  I18N_KEY = 'activerecord.attributes.person.correspondence_languages'.freeze

  def format_mailing_list_correspondence_language(mailing_list)
    lang = mailing_list.correspondence_language
    lang.present? ? I18n.t([I18N_KEY, lang].join('.')) : t('global.all')
  end
end
