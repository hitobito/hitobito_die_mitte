# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'spec_helper'

describe DieMitte::PersonSerializer do
  let(:person) { people(:sekretaer).decorate }
  let(:controller) { double.as_null_object }
  let(:serializer) { PersonSerializer.new(person, controller: controller)}
  let(:hash) { serializer.to_hash }

  subject { hash[:people].first }

  it 'has assumptions' do
    expect(hash.keys).to include(:people)
    expect(person.website).to eq 'hitobito.example.com'
  end

  context 'without details' do
    before do
      allow(controller).to receive(:can?).and_return(false)
    end

    it 'has a website' do
      is_expected.to have_key(:website)

      expect(subject[:website]).to eq 'hitobito.example.com'
    end
  end
end
