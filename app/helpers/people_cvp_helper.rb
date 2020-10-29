# frozen_string_literal: true

module PeopleCvpHelper
  PERSON_I18N_KEY_PREFIX =  'activerecord.attributes.person'.freeze

  def possible_person_civil_statuses
    Cvp::Person::CIVIL_STATUSES.map do |key|
      [key, t("#{PERSON_I18N_KEY_PREFIX}.civil_statuses.#{key}")]
    end
  end

  def format_person_correspondence_language(person)
    t("#{PERSON_I18N_KEY_PREFIX}.correspondence_languages.#{person.correspondence_language}")
  end

  def format_person_civil_status(person)
    t("#{PERSON_I18N_KEY_PREFIX}.civil_statuses.#{person.civil_status}")
  end

  def format_person_salutation(person)
    t("activerecord.models.salutation.available.#{person.salutation}.label") if person.salutation.present?
  end
end
