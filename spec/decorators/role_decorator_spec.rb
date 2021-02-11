# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'spec_helper'

describe RoleDecorator, :draper_with_helpers  do
  include Rails.application.routes.url_helpers

  def group_path(name)
    path = Rails.application.routes.url_helpers.group_path(groups(name))
    "\"#{path}\""
  end

  it "renders normal role within a <strong> tag for ordinary role" do
    aside = RoleDecorator.new(roles(:sekretaer)).for_aside
    expect(aside).to eq '<strong>Leitung</strong>'
  end

  it "renders normal role within a <strong> tag for ordinary role and label" do
    roles(:sekretaer).update(label: 'General')
    aside = RoleDecorator.new(roles(:sekretaer)).for_aside
    expect(aside).to eq '<strong>Leitung (General)</strong>'
  end

  it "renders hiearchy with links for Mitglieder Role" do
    roles(:thuner).update(label: 'Einzelmitglied')
    aside = RoleDecorator.new(roles(:thuner)).for_aside

    html = [
      "<strong>Mitglied (Einzelmitglied)</strong>",
      "<strong>Mitglied - Kanton <a href=#{group_path(:be)}>Bern</a></strong>",
      "<strong>Mitglied - Schweiz <a href=#{group_path(:die_mitte)}>Die Mitte</a></strong>"
    ]
    expect(aside.split('<br />')).to eq html
  end
end
