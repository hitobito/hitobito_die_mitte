# encoding: utf-8

#  Copyright (c) 2012-2020, CVP Schweiz. This file is part of
#  hitobito_cvp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_cvp.

module Cvp::Person
  extend ActiveSupport::Concern

  included do
    include I18nEnums

    Person::PUBLIC_ATTRS << :title << :website << :correspondance_language << :zivil_status

    CORRESPONDANCE_LANGUAGES = %w(de fr en it).freeze
    CIVIL_STATES = %w(single registered_partnership married engaged divorced).freeze

    i18n_enum :correspondance_language, CORRESPONDANCE_LANGUAGES

    i18n_enum :civil_status, CIVIL_STATES
  end
end
