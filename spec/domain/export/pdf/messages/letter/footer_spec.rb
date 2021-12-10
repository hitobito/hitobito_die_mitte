# frozen_string_literal: true

#  Copyright (c) 2021, CVP Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

require "spec_helper"

describe DieMitte::Export::Pdf::Messages::Letter::Footer do
  let(:options)    { {} }
  let(:sekretariat)  { groups(:sekretariat) }
  let(:top_leader) { people(:sekretaer) }
  let(:recipient) do
    MessageRecipient
      .new(message: letter, person: top_leader, address: "Top Leader\n\nSupertown")
  end
  let(:letter)     { Message::Letter.new(body: 'simple text', group: sekretariat,
                                         shipping_method: 'normal', pp_post: 'CH-3030 Bern, Belpstrasse 37') }
  let(:pdf)        { Prawn::Document.new }
  let(:analyzer) { PDF::Inspector::Text.analyze(pdf.render) }
  let(:column_attrs) { { footer_column_1: "Hitobito AG\nSchweiz",
                         footer_column_2: "Belpstrasse 37\nPostfach\nCH-3030 Bern",
                         footer_column_3: "T 030 123 45 67\ninfo@example.com\nwww.example.com",
                         footer_column_4: "2021-12-09\nBern, Schweiz" } }

  subject { described_class.new(pdf, letter, options) }

  before do
    GroupSetting.create!(target: sekretariat, var: :messages_letter, **column_attrs)
  end

  describe 'footer columns' do
    it "is present" do
      subject.render(recipient)
      expect(text_with_position).to eq [
        [36, 27, 'Hitobito AG'],
        [36, 14, 'Schweiz'],
        [151, 27,  'Belpstrasse 37'],
        [151, 14,  'Postfach'],
        [151, 0,  'CH-3030 Bern'],
        [266, 27,  'T 030 123 45 67'],
        [266, 14,  'info@example.com'],
        [266, 0,  'www.example.com'],
        [381, 27,  '2021-12-09'],
        [381, 14,  'Bern, Schweiz'],
      ]
    end

    context "stamping" do
      let(:stamps) { pdf.instance_variable_get('@stamp_dictionary_registry') }
      let(:options) { { stamped: true } }

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
