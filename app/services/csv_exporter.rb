
# frozen_string_literal: true

# Because the export feature is so fast right now background jobs using something like side would
# be more difficult then just using this export tool. I have also found in past work that exporting
# to Excel tends to fall under the accuracy category with is something you lose with background jobs
# However doing background jobs is simple and with this code you can scale based off the need
class CsvExporter
  attr_accessor :records, :serializer
  def initialize(records, serializer)
    raise 'I am missing my serializer required to export to CSV' if serializer.nil?
    self.serializer = serializer
    self.records    = records
  end

  def to_csv
    CSV.generate do |csv|
      csv << serializer.csv_headers
      records.each do |record|
        csv << serializer.new(record).to_a
      end
    end
  end
end
