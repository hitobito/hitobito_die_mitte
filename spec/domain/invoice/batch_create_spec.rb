# frozen_string_literal: true

#  Copyright (c) 2022, Die Mitte Schweiz. This file is part of
#  hitobito_cvp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require 'spec_helper'

describe Invoice::BatchCreate do
  include ActiveJob::TestHelper

  let(:mailing_list) { mailing_lists(:list) }
  let(:group) { groups(:sekretariat) }
  let(:layer) { groups(:die_mitte) }
  let(:person) { people(:sekretaer) }
  let(:other_person) { people(:thuner) }


    it '#call creates invoices for abo with variable donation amount' do
    Subscription.create!(mailing_list: mailing_list,
                         subscriber: group,
                         role_types: [Group::BundSekretariat::Leitung])

    list = InvoiceRun.new(receiver: mailing_list, group: group, title: :title)

    layer.invoice_config.update_attribute(:donation_increase_percentage, 5)
    layer.invoice_config.update_attribute(:donation_calculation_year_amount, 2)
    fabricate_donation(50, 1.year.ago)
    fabricate_donation(150, 2.years.ago)
    fabricate_donation(2000, 2.years.ago)
    fabricate_donation(300, 2.years.ago)
    fabricate_donation(100, 2.years.ago)

    invoice = Invoice.new(title: 'invoice', group: group)
    invoice.invoice_items.build(name: 'pens', unit_cost: 1.5)
    invoice.invoice_items.build(name: 'variable donation', unit_cost: 0, type: InvoiceItem::VariableDonation.sti_name)
    list.invoice = invoice
    list.save!

    Invoice::BatchCreate.call(list)

    expect(list.reload).to have(1).invoices
    expect(list.receiver).to eq mailing_list
    expect(list.recipients_total).to eq 1
    expect(list.recipients_paid).to eq 0
    
    # median amount is 150, raise by 5%: 150 * 1.05 = 157.5, rounded up to next 5 = 160, add other invoice_item: 160 + 1.5 = 161.5

    expect(list.amount_total).to eq 161.5
    expect(list.amount_paid).to eq 0
  end

  it '#call deletes invoice if variable donation with amount 0 is the only invoice item' do
    Subscription.create!(mailing_list: mailing_list,
                         subscriber: group,
                         role_types: [Group::BundSekretariat::Leitung])

    list = InvoiceRun.new(receiver: mailing_list, group: group, title: :title)

    layer.invoice_config.update_attribute(:donation_increase_percentage, 5)
    layer.invoice_config.update_attribute(:donation_calculation_year_amount, 2)

    invoice = Invoice.new(title: 'invoice', group: group)
    invoice.invoice_items.build(name: 'variable donation', unit_cost: 0, type: InvoiceItem::VariableDonation.sti_name)
    list.invoice = invoice

    Invoice::BatchCreate.call(list)

    expect(list.reload).to have(0).invoices
    expect(list.receiver).to eq mailing_list
  end

  it '#call deletes variable donation invoice item with amount 0' do
    Subscription.create!(mailing_list: mailing_list,
                         subscriber: group,
                         role_types: [Group::BundSekretariat::Leitung])

    list = InvoiceRun.new(receiver: mailing_list, group: group, title: :title)

    layer.invoice_config.update_attribute(:donation_increase_percentage, 5)
    layer.invoice_config.update_attribute(:donation_calculation_year_amount, 2)

    invoice = Invoice.new(title: 'invoice', group: group)
    invoice.invoice_items.build(name: 'pens', unit_cost: 15.5)
    invoice.invoice_items.build(name: 'variable donation', unit_cost: 0, type: InvoiceItem::VariableDonation.sti_name)
    list.invoice = invoice
    list.save!

    expect do
      Invoice::BatchCreate.call(list)
    end.to change { group.invoice_items.count }.by(1)

    expect(list.reload).to have(1).invoices
    expect(list.receiver).to eq mailing_list
    expect(list.recipients_total).to eq 1
    expect(list.recipients_paid).to eq 0
    
    expect(list.amount_total).to eq 15.5
    expect(list.amount_paid).to eq 0
  end

  private

  def fabricate_donation(amount, received_at = 1.year.ago)
    invoice = Fabricate(:invoice, due_at: 10.days.from_now, creator: other_person, recipient: person, group: layer, state: :payed)
    Payment.create!(amount: amount, received_at: received_at, invoice: invoice)
  end
end
