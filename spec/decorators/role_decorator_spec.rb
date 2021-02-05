# encoding: utf-8

#  Copyright (c) 2012-2020, CVP Schweiz. This file is part of
#  hitobito_cvp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_cvp.

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
      "<strong>Mitglied - Schweiz <a href=#{group_path(:cvp)}>CVP/PDC/PPD</a></strong>"
    ]
    expect(aside.split('<br />')).to eq html
  end
end
