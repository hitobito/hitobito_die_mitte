# frozen_string_literal: true

#  Copyright (c) 2023, Die Mitte Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

require 'spec_helper'

describe MessagesController do
  let(:list)       { mailing_lists(:leaders) }
  let(:nesting)    { { group_id: list.group_id, mailing_list_id: list.id } }
  let(:sekretaer) { people(:sekretaer) }

  before { sign_in(sekretaer) }


  context 'POST#create' do
    it 'saves LetterWithInvoice with dynamic invoice_item variable_donation' do
      Subscription.create!(mailing_list: list, subscriber: sekretaer)

      post :create, params: nesting.merge(
        message: {
          subject: 'Mitgliedsbeitrag',
          type: 'Message::LetterWithInvoice',
          body: 'Bitte einzahlen',
          invoice_attributes: {
            invoice_items_attributes: {
              '0' => { name: 'Variabler Spendenaufruf', type: InvoiceItem::VariableDonation.sti_name, count: '1', unit_cost: '0' }
            }
          }
        }
      )
      expect(assigns(:message)).to be_persisted
      invoice = assigns(:message).invoice
      expect(invoice.invoice_items.size).to eq(1)
      expect(invoice.invoice_items.first).to be_an_instance_of(InvoiceItem::VariableDonation)
    end
  end
end
