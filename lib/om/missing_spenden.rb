require "csv"
module MissingSpenden

  # 1. Dump von prod holen
  # 2. Fehlende Kampagnen importieren
  # 3. Fehlende Spenden importieren
  # 4. Spenden die keine Person zugeordnet werden können anschauen (Familienmitglieder)
  # 5. Total updaten
  #
  # 17k importierbar
  # 7k nicht zuordenbar (familien, firmen)
  # -> wie finden wir diese personen wieder?
  #
  #
  NAMEN = [
    '2020-03 Fundraising DIE POLITIK',
    '2020-09-14 Fundraising bisherige Spender 2015-2020',
    '2020-11 Fundraising DIE POLITIK',
    'Spendenbestätigungen 2019'
  ]

  MISSING_INVOICE_LISTS = "#{ENV['HOME']}/missing_kampagnen.csv"
  INVOICES = "#{ENV['HOME']}/updatable_invoices.csv"
  INVOICES_NEW = "#{ENV['HOME']}/new_invoices.csv"
  INVOICES_SHORT = "#{ENV['HOME']}/updatable_invoices_short.csv"
  SPENDEN_UNASSIGNABLE = "#{ENV['HOME']}/spenden_unassignable.csv"


  class Import

    def run
      ActiveRecord::Base.transaction do
        with_count do
          import_invoice_lists
          update_invoices
          import_invoices
          update_invoice_lists
        end
      end
    end

    def with_count
      print_numbers
      yield
      print_numbers
    end

    def print_numbers
      puts "InvoiceLists: #{InvoiceList.count}"
      puts "Invoices: #{Invoice.count}"
      puts " InvoicesWithRecipients: #{Invoice.joins(:recipient).count}"
      puts " InvoicesWithList: #{Invoice.joins(:invoice_list).count}"
      puts " InvoicesWithListAndRecipients: #{Invoice.joins(:recipient).count}"
    end

    def update_invoice_lists
      invoice_lists.find_each(&:update_paid)
      invoice_lists.find_each(&:update_total)
    end

    def invoice_lists
      InvoiceList.where(title: NAMEN)
    end

    def import_invoice_lists
      kampangnen = CSV.open(MISSING_INVOICE_LISTS, headers: true).collect(&:to_h)
      InvoiceList.insert_all(kampangnen)
    end

    def import_invoices
      now = Time.current
      titles = invoice_lists.pluck(:id, :title).to_h
      sequence_number = bund.invoice_config.sequence_number
      invoices = CSV.open(INVOICES_NEW, headers: true).each.with_index(sequence_number).collect do |row, index|
        row.to_h.symbolize_keys.merge(
          state: :payed,
          group_id: bund.id,
          sequence_number: "#{bund.id}-#{index}",
          esr_number: '',
          reference: ''
        )
      end

      invoice_config = bund.invoice_config
      invoice_config.update(sequence_number: sequence_number + invoices.count)

      Invoice.insert_all(invoices)

      # can i still create an in invoice
    end

    def bund
      @bund ||= Group::Bund.first
    end

    def update_invoices
      now = Time.current

      spenden = CSV.open(INVOICES, headers: true).collect do |spende|
        spende.to_h.symbolize_keys.except(:key, :name).merge(updated_at: now)
      end
      Invoice.upsert_all(spenden)
    end
  end

  class Export

    def run
      puts "kampagnen: #{kampagnen.count}"
      puts "spenden: #{spenden.count}"
      puts " assignable: #{assignable_spenden.count}"
      puts "invoices: #{invoices.count}"
      puts "  assigned: #{invoices_assigned.count}"
      puts "  unassigned: #{invoices_unassigned.count}"
      puts "  assignable: #{assignable.count}"
      puts "  unassignable: #{unassignable.count}"
      puts "  new: #{new_invoices.count}"

      export_kampagnen
      export_invoices
      export_invoices_new
      export_invoices_summary
      export_unassignable
    end

    def export_invoices
      CSV.open(INVOICES, "wb") do |csv|
        csv << decorated_assignable_spenden.first.keys
        decorated_assignable_spenden.each do |spende|
          csv << spende.values
        end
        puts "Exported Invoices: #{decorated_assignable_spenden.size}"
      end
    end

    def export_invoices_new
      CSV.open(INVOICES_NEW, "wb") do |csv|
        csv << new_invoices.first.keys
        new_invoices.each do |spende|
          csv << spende.values
        end
        puts "Exported New Invoices: #{new_invoices.size}"
      end
    end

    def export_unassignable
      CSV.open(SPENDEN_UNASSIGNABLE, "wb") do |csv|
        csv << unassignable_spenden.first.keys
        unassignable_spenden.each do |spende|
          csv << spende.values
        end
      end

    end

    def export_invoices_summary
      columns = %i(id title total recipient_id name)

      CSV.open(INVOICES_SHORT, "wb") do |csv|
        csv << columns
        (decorated_assignable_spenden + new_invoices).each do |spende|
          attrs = spende.slice(*columns)
          recipient_name = people_names[spende[:recipient_id]]
          csv << attrs.merge(recipient_name: recipient_name).values
        end
      end
    end

    def export_kampagnen
      CSV.open(MISSING_INVOICE_LISTS, "wb") do |csv|
        csv << kampagnen.first.prepare.keys
        kampagnen.find_each do |kampagne|
          csv <<  kampagne.prepare.values(group_id: Group::Bund.first.id)
        end
        puts "Exported Kampagnen: #{kampagnen.size}"
      end
    end

    def new_invoices
      assignable_spenden.where.not(spenden_nummer: invoices.pluck(:id)).collect do |row|
        next unless recipient_id(row['kunden_id'])

        row.prepare.merge(
          invoice_list_id: row.kampagne.kampagnen_nummer,
          recipient_id: recipient_id(row['kunden_id']),
          title: row.kampagne.bezeichnung
        )
      end.compact
    end

    def decorated_assignable_spenden
      @decorated_assignable_spenden ||= spenden.collect do |row|
        next unless recipient_id(row['kunden_id'])
        next unless invoices_by_id.key?(row.spenden_nummer)

        prepare(row)
      end.compact
    end

    def prepare(row)
      recipient_id = recipient_id(row['kunden_id'])
      invoices_by_id[row.spenden_nummer].merge(
        invoice_list_id: row.kampagnen_nummer,
        title: row.kampagne.bezeichnung,
        recipient_id: recipient_id,
      )
    end

    def recipient_id(kunden_id)
      people[kunden_id] ||
        household_ids[kunden_id] ||
        kundennummern[stale_ids[kunden_id]]
    end

    def key(kunden_id)
      if people.key?(kunden_id)
        :people
      elsif household_ids.key?(kunden_id)
        :household
      elsif stale_ids.key?(kunden_id)
        :stale_ids
      end
    end

    def people
      @people ||= Person.where.not(kunden_id: nil).pluck(:kunden_id, :id).to_h
    end

    def people_names
      @people_names ||= Person.where.not(kunden_id: nil)
        .pluck(Arel.sql("id, CONCAT_WS(' ', first_name, last_name)")).to_h
    end

    def kundennummern
      @kundennummer ||= Person.where.not(kundennummer: nil).pluck(:kundennummer, :id).to_h
    end

    def spenden
      @spenden ||= Spende.where(kampagnen_nummer: kampagnen.pluck(:kampagnen_nummer))
        .includes(:kampagne)
    end

    def assignable_spenden
      spenden.where(kunden_id: kunden_ids)
    end

    def invoices
      Invoice.where(reference: "", id: @spenden.collect(&:id))
    end

    def invoices_by_id
      @invoices_by_id ||= invoices.collect do |invoice|
        [invoice.id, invoice.attributes.symbolize_keys]
      end.to_h
    end

    def invoices_assigned
      invoices.joins(:recipient)
    end

    def invoices_unassigned
      invoices.left_joins(:recipient).where(people: { id: nil })
    end

    def unassignable
      (spenden.collect(&:kunden_id) - kunden_ids ).uniq
    end

    def unassignable_spenden
      @unassignable_spenden ||= spenden.includes(:kontakt).where(kunden_id: unassignable).collect do |spende|
        spende.prepare.merge(kontakt: spende.kontakt.to_s, kunden_id: spende.kunden_id)
      end
    end

    def kunden(kunden_id)
      @kunden ||= Kontakt.index_by { |k| [k.kunden_id, k.to_s] }.to_h
      @kunden.fetch(kunden_id)
    end

    def assignable
      spenden
        .where(spenden_nummer: invoices_unassigned.pluck(:id),
               kunden_id: household_ids.keys + stale_ids.keys)
    end

    def kunden_ids
      @kunden_id ||= (people_ids.keys + household_ids.keys + stale_ids.keys).compact.uniq
    end

    def stale_ids
      @stale_ids ||= YAML.load_file("#{Wagons.all[0].root}/stale_ids.yaml")
    end

    def people_ids
      @people_ids ||= Person.where.not(kunden_id: nil).pluck(:kunden_id, :kundennummer).to_h
    end

    def household_ids
      @household_ids ||= Person.household.pluck(:household_key, :id).to_h
    end

    def kampagnen
      @kampagnen_nummer ||= Kampagne.where.not(kampagnen_nummer: InvoiceList.pluck(:id))
        .where(postaufgabe_am: Date.new(2020,1,1)..Date.new(2021,12,31))
        .where(bezeichnung: NAMEN)
        .where.not(kampagnen_nummer: 14782)
    end
  end

end


