# encoding: utf-8

#  Copyright (c) 2012-2020, CVP Schweiz. This file is part of
#  hitobito_cvp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_cvp.


require 'spec_helper'

describe PeopleController do

  render_views

  let(:body)      { Capybara::Node::Simple.new(response.body) }
  let(:sekretaer) { people(:sekretaer) }

  let(:people_table) { body.all('#main table tbody tr') }
  let(:pagination_info) { body.find('.pagination-info').text.strip }
  let(:members_filter) { body.find('.toolbar-pills > ul > li:nth-child(1)') }
  let(:custom_filter) { body.find('.toolbar-pills > ul > li.dropdown') }

  before { sign_in(sekretaer) }

  it 'GET#index lists both members on top layer' do
    get :index, params: { group_id: groups(:cvp).id }
    expect(members_filter.text).to eq 'Mitglieder (2)'
    expect(members_filter[:class]).to eq 'active'
    expect(custom_filter[:class]).not_to eq 'active'

    expect(pagination_info).to eq '2 Personen angezeigt.'
    expect(people_table).to have(2).item
  end

  it 'GET#index accepts filter params and lists only single member' do
    roles = { role_type_ids: Group::KantonMitglieder::Mitglied.id }
    get :index, params: { group_id: groups(:cvp).id, filters: { role: roles }, range: 'deep' }

    expect(custom_filter[:class]).to eq 'dropdown active'
    expect(members_filter.text).to eq 'Mitglieder (2)'
    expect(members_filter[:class]).not_to eq 'active'

    expect(pagination_info).to eq '1 Person angezeigt.'
    expect(people_table).to have(1).item

  end

  it 'GET#index lists single member for kanton bern  on top layer' do
    get :index, params: { group_id: groups(:be).id }
    expect(members_filter.text).to eq 'Mitglieder (1)'
    expect(pagination_info).to eq '1 Person angezeigt.'
    expect(people_table).to have(1).item
  end

  it 'GET#index lists single member on Mitglieder group' do
    get :index, params: { group_id: groups(:be_thun_mitglieder).id }
    expect(members_filter.text).to eq 'Mitglieder (1)'
    expect(pagination_info).to eq '1 Person angezeigt.'
    expect(people_table).to have(1).item
  end

end
