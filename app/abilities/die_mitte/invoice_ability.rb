# frozen_string_literal: true

#  Copyright (c) 2023, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::InvoiceAbility
  extend ActiveSupport::Concern

  included do
    on(Invoice) do
      permission(:complete_finance).may(:show, :create, :edit, :update, :destroy).all
    end

    on(InvoiceRun) do
      permission(:complete_finance).may(:update, :destroy, :create, :index_invoices).all
    end

    on(InvoiceArticle) do
      permission(:complete_finance).may(:show, :new, :create, :edit, :update, :destroy).all
    end

    on(InvoiceConfig) do
      permission(:complete_finance).may(:show, :edit, :update).all
    end

    on(Payment) do
      permission(:complete_finance).may(:create).all
    end

    on(PaymentReminder) do
      permission(:complete_finance).may(:create).all
    end
  end
end
