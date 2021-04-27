# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

require 'spec_helper'

describe Export::Tabular::People::PersonRow do

  before do
  end

  let(:person) { people(:thuner) }
  let(:row) { Export::Tabular::People::PersonRow.new(person) }

  subject { row }

  context 'salutation' do
    it('renders full salutation') { expect(row.fetch(:salutation)).to eq 'Liebe*r A' }
  end

end
