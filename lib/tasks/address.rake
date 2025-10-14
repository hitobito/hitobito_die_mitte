namespace :address do
  desc "Check Person addresses FILE=01_KontaktDaten.csv, requires csvkit"
  task :check, [:file, :environment] do |_t, args|
    fail "Needs KontaktDaten file to work with" unless File.exist?(args[:file].to_s)
    AddressOverview.new(args[:file]).run
  end
end

class AddressOverview
  def initialize(file)
    @file = file
  end

  def addresses
    @addresses ||= Rails.root.join("tmp", "addresses.csv", "addresses.csv")
  end

  def write_addresses
    pipeline = [
      "csvgrep -e latin1 -c Loeschflag -m ' ' -d '|' #{@file}",
      "csvgrep -c Land -m 'CH'",
      "csvgrep -c Strasse -m ' ' -i",
      "csvgrep -c Postleitzahl -m ' ' -i",
      "csvcut -c Strasse,Hausnummer,HausnummerZusatz,Postleitzahl,Land"
    ].join(" | ")
    addresses.write(`#{pipeline}`)
  end

  def rows
    raw = CSV.read(addresses, headers: true)
    raw.reject do |r|
      r["Postleitzahl"].blank?
    end.sort_by do |r|
      r["Postleitzahl"].to_i
    end.tap do |sorted|
      puts "read #{raw.size} rows, using #{sorted.size}"
    end
  end

  def number?(address, row)
    number = [row["Hausnummer"], row["HausnummerZusatz"].presence].compact.join
    address.numbers.collect(&:to_s).include?(number.downcase)
  end

  def counts
    @counts ||= OpenStruct.new(found: 0, street_missing: 0, number_missing: 0, missing: [])
  end

  def each_slice(rows) # rubocop:todo Metrics/AbcSize
    rows.each_slice(1000) do |slice|
      current = counts.dup
      slice.each do |row|
        yield row
      end
      puts "found: #{counts.found - current.found}, " \
        "street_missing: #{counts.street_missing - current.street_missing} " \
        "number_missing: #{counts.number_missing - current.number_missing} " \
    end
    File.open("missing_rows.csv", "w") do |f|
      counts.missing.each { |row| f.write(row.to_csv) }
    end
  end

  def run # rubocop:todo Metrics/AbcSize
    each_slice(rows) do |row|
      addresses = Address.search(row["Postleitzahl"], row["Strasse"])
      if addresses.one? { |address| number?(address, row) }
        next counts.found += 1
      elsif addresses.empty?
        counts.street_missing += 1
        counts.missing << row
      else
        counts.number_missing += 1
        counts.missing << row
      end
    end
  end
end
