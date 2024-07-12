#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::Person::Filter::Attributes
  I18N_KEY = "activerecord.attributes.person.correspondence_languages".freeze

  def persisted_attribute_condition_sql(key, value, constraint)
    if key == "correspondence_language" && value.present?
      value = from_translations(value)&.first || value
    end

    super
  end

  def from_translations(value)
    translations.find { |_, list| list.any? { |item| item.downcase.match(value.downcase) } }
  end

  def translations
    @translations ||= Settings.application.languages.keys.each_with_object({}) do |lang, memo|
      I18n.t(I18N_KEY, locale: lang).each do |key, value|
        memo[key] ||= []
        memo[key] << value
      end
    end.stringify_keys
  end
end
