# frozen_string_literal: true

class Salutation

  I18N_KEY_PREFIX = 'activerecord.models.salutation'.freeze

  attr_reader :person

  class << self
    def available
      I18n.t("#{I18N_KEY_PREFIX}.available").each_with_object({}) do |s, h|
        h[s.first.to_s] = s.last[:label]
      end
    end
  end

  def initialize(person)
    @person = person
  end

  def label
    I18n.translate("#{I18N_KEY_PREFIX}.#{salutation}.label")
  end

  def value
    gender = person.gender.presence || 'other'
    I18n.translate("#{I18N_KEY_PREFIX}.#{salutation}.value.#{gender}",
                   first_name: person.first_name,
                   last_name: person.last_name,
                   company_name: person.company_name,
                   title: person.title,
                   title_last_name: "#{person.title} #{person.last_name}".strip)
  end

  def salutation
    if @person.salutation?
      "available.#{@person.salutation}"
    else
      'default'
    end
  end

end
