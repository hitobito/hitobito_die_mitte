# frozen_string_literal: true

#  Copyright (c) 2012-2026, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require "spec_helper"

describe "mailing_lists/messages/_actions_show.html.haml" do
  let(:mailing_list) { mailing_lists(:leaders) }
  let(:group) { groups(:die_mitte) }

  let(:message) {
    Message::LetterWithInvoice.create!(
      subject: "A wonderful number",
      body: "42!",
      mailing_list:,
      group:,
      state: "finished",
      invoice_attributes: {"invoice_items_attributes" => {
        "1" => {"name" => "Answer to everything", "unit_cost" => "42", "vat_rate" => "19", "_destroy" => "false"}
      }}
    )
  }

  subject(:dom) { Capybara::Node::Simple.new(render) }

  before do
    allow(view).to receive(:entry).and_return(message)
    allow(view).to receive(:can?).with(anything, message).and_return(true)

    allow(view).to receive(:path_args).with(Message::LetterWithInvoice)
      .and_return([group, mailing_list, Message::LetterWithInvoice])
  end

  it "should have csv export button in addition to other buttons" do
    expect(dom).to have_link("CSV exportieren")
  end
end
