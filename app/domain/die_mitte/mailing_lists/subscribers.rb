#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::MailingLists::Subscribers
  def people
    super.where(correspondence_language_condition)
  end

  private

  def correspondence_language_condition
    return {} if @list.correspondence_language.blank?

    {correspondence_language: @list.correspondence_language}
  end
end
