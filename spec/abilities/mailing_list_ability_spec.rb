# frozen_string_literal: true

#  Copyright (c) 2023, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'spec_helper'

describe MailingListAbility do
  let(:user) { role.person }

  subject { Ability.new(user.reload) }

  context 'as it support' do
    context 'for mailing list in lower layer' do
      let(:mailing_list) { Fabricate(:mailing_list, group: groups(:zh)) }
      let(:role) { Fabricate(Group::BundSekretariat::ItSupport.sti_name.to_sym, group: groups(:sekretariat)) }

      [:show, :index_subscriptions, :export_subscriptions, :create, :update, :destroy].each do |action|
        it "can #{action}" do
          is_expected.to be_able_to(action, mailing_list)
        end
      end
    end
  end
end
