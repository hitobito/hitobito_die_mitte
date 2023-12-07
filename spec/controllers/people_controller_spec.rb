# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

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

  it 'should permit the die_mitte attributes' do
    expect(PeopleController.permitted_attrs).to include(:title)
    expect(PeopleController.permitted_attrs).to include(:salutation)
    expect(PeopleController.permitted_attrs).to include(:website)
    expect(PeopleController.permitted_attrs).to include(:correspondence_language)
    expect(PeopleController.permitted_attrs).to include(:website)
  end

  it 'GET#index lists both members on top layer' do
    get :index, params: { group_id: groups(:die_mitte).id }
    expect(members_filter.text).to eq 'Mitglieder (2)'

    expect(members_filter.find('a')[:class]).to include 'active'
    expect(custom_filter[:class]).not_to include 'active'

    expect(pagination_info).to eq '2 Personen angezeigt.'
    expect(people_table).to have(2).item
  end

  it 'GET#index accepts filter params and lists only single member' do
    roles = { role_type_ids: Group::KantonMitglieder::Mitglied.id }
    get :index, params: { group_id: groups(:die_mitte).id, filters: { role: roles }, range: 'deep' }

    expect(custom_filter[:class]).to include 'dropdown'
    expect(custom_filter[:class]).to include 'active'
    expect(members_filter.text).to eq 'Mitglieder (2)'
    expect(members_filter.find('a')[:class]).not_to include 'active'

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

  describe 'PUT update' do
    it 'updates die_mitte atts using patch' do
      params = {
        id: sekretaer.id,
        group_id: groups(:die_mitte).id,
        person: {
          first_name: 'updated_name',
          title: 'Frau',
          website: 'example.com',
          correspondence_language: 'de',
          civil_status: 'single',
          salutation: 'lieber_vorname'
        }
      }

      patch :update, params: params

      sekretaer.reload

      expect(response).to have_http_status(302)
      expect(sekretaer.first_name).to eq('updated_name')
      expect(sekretaer.title).to eq('Frau')
      expect(sekretaer.website).to eq('example.com')
      expect(sekretaer.correspondence_language).to eq('de')
      expect(sekretaer.civil_status).to eq('single')
      expect(sekretaer.salutation).to eq('lieber_vorname')
    end
  end
end
