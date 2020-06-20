desc 'import_flight_chart_data'
task :import_flight_chart_data => :environment do
  require "csv"
  file = File.join(Rails.root, 'flight_chart_data.csv')
  csv_text = File.read(file)
  csv = CSV.parse(csv_text)
  csv.each do |row|
    Flightchart.create(mold: row[0], chart_id: row[1])
  end
end