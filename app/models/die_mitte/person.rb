# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

# Table name: people
#
#  id                        :integer          not null, primary key
#  first_name                :string(255)
#  last_name                 :string(255)
#  company_name              :string(255)
#  nickname                  :string(255)
#  company                   :boolean          default(FALSE), not null
#  email                     :string(255)
#  address                   :string(1024)
#  zip_code                  :string(255)
#  town                      :string(255)
#  country                   :string(255)
#  gender                    :string(1)
#  birthday                  :date
#  additional_information    :text(65535)
#  contact_data_visible      :boolean          default(FALSE), not null
#  created_at                :datetime
#  updated_at                :datetime
#  encrypted_password        :string(255)
#  reset_password_token      :string(255)
#  reset_password_sent_at    :datetime
#  remember_created_at       :datetime
#  sign_in_count             :integer          default(0)
#  current_sign_in_at        :datetime
#  last_sign_in_at           :datetime
#  current_sign_in_ip        :string(255)
#  last_sign_in_ip           :string(255)
#  picture                   :string(255)
#  last_label_format_id      :integer
#  creator_id                :integer
#  updater_id                :integer
#  primary_group_id          :integer
#  failed_attempts           :integer          default(0)
#  locked_at                 :datetime
#  authentication_token      :string(255)
#  show_global_label_formats :boolean          default(TRUE), not null
#  household_key             :string(255)
#  title                     :string(255)      not null
#  website                   :string(255)      not null
#  correspondence_language   :string(255)      default('de'), not null
#  civil_status              :string(255)      default('single'), not null

module DieMitte::Person
  extend ActiveSupport::Concern

  CIVIL_STATUSES = %w[single registered_partnership married divorced widowed].freeze

  included do
    include I18nEnums

    Person::PUBLIC_ATTRS << :title << :website << :correspondence_language <<
      :civil_status << :salutation

    i18n_enum :correspondence_language, Settings.application
      .correspondence_languages
      .to_hash
      .keys
      .collect(&:to_s)

    i18n_enum :civil_status, CIVIL_STATUSES

    def salutation_value
      Salutation.new(self).value
    end

    alias_method_chain :finance_groups, :complete_finance_permission
  end

  def finance_groups_with_complete_finance_permission
    if groups_with_permission(:complete_finance).any?
      Group.where(type: Group.all_types.select(&:layer)).to_a
    else
      finance_groups_without_complete_finance_permission
    end
  end
end
