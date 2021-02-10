# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

# == Schema Information
#
# Table name: people
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  company_name           :string
#  nickname               :string
#  company                :boolean          default(FALSE), not null
#  email                  :string
#  address                :string(1024)
#  zip_code               :string
#  town                   :string
#  country                :string
#  gender                 :string(1)
#  birthday               :date
#  additional_information :text
#  contact_data_visible   :boolean          default(FALSE), not null
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  picture                :string
#  last_label_format_id   :integer
#  creator_id             :integer
#  updater_id             :integer
#  primary_group_id       :integer
#  failed_attempts        :integer          default(0)
#  locked_at              :datetime
#  authentication_token   :string
#

require 'spec_helper'

describe Person do

  let(:person) { people(:thuner) }

  describe 'salutation' do

    subject { person.salutation_value }

    it 'has a value' do
      is_expected.to eq('Liebe*r A')
    end

    it 'has a default value when the person has no salutation set' do
      person.update(salutation: nil)
      is_expected.to eq('Hallo A')
    end

  end

end
