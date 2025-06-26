# frozen_string_literal: true

#  Copyright (c) 2021, CVP Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

require "spec_helper"

describe DieMitte::Export::Pdf::Messages::Letter::Footer do
  let(:options) { {} }
  let(:sekretariat) { groups(:sekretariat) }
  let(:top_leader) { people(:sekretaer) }
  let(:recipient) do
    MessageRecipient
      .new(message: letter, person: top_leader, address: "Top Leader\n\nSupertown")
  end
  let(:letter) {
    Message::Letter.new(body: "simple text", group: sekretariat,
      shipping_method: "normal", pp_post: "CH-3030 Bern, Belpstrasse 37")
  }
  let(:pdf) { Export::Pdf::Document.new.pdf }
  let(:analyzer) { PDF::Inspector::Text.analyze(pdf.render) }
  let(:column_attrs) {
    {footer_column_1: "Hitobito AG\nSchweiz\nCH00 0000 0000 0000 0000 0",
     footer_column_2: "Belpstrasse 37\nPostfach\nCH-3030 Bern",
     footer_column_3: "T 030 123 45 67\ninfo@example.com\nwww.example.com",
     footer_column_4: "2021-12-09\nBern, Schweiz"}
  }

  subject { described_class.new(pdf, letter, options) }

  before do
    sekretariat.letter_footer_column_1 = column_attrs[:footer_column_1]
    sekretariat.letter_footer_column_2 = column_attrs[:footer_column_2]
    sekretariat.letter_footer_column_3 = column_attrs[:footer_column_3]
    sekretariat.letter_footer_column_4 = column_attrs[:footer_column_4]
    sekretariat.save!
  end

  describe "footer columns" do
    it "is present" do
      subject.render(recipient)
      pdf.render_file("/tmp/test.pdf")
      expect(text_with_position).to eq [
        [57, 48, "Hitobito AG"],
        [57, 37, "Schweiz"],
        [57, 26, "CH00 0000 0000 0000 0000 0"],
        [172, 48, "Belpstrasse 37"],
        [172, 37, "Postfach"],
        [172, 26, "CH-3030 Bern"],
        [287, 48, "T 030 123 45 67"],
        [287, 37, "info@example.com"],
        [287, 26, "www.example.com"],
        [402, 48, "2021-12-09"],
        [402, 37, "Bern, Schweiz"]
      ]
    end

    context "stamping" do
      let(:stamps) { pdf.instance_variable_get(:@stamp_dictionary_registry) }
      let(:options) { {stamped: true} }

      it "includes all columns" do
        subject.render(recipient)
        expect(stamps.keys).to eq [:footer_columns]
      end
    end
  end

  def text_with_position
    analyzer.positions.each_with_index.collect do |p, i|
      p.collect(&:round) + [analyzer.show_text[i]]
    end
  end
end
