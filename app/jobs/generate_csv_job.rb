# frozen_string_literal: true

class GenerateCsvJob < ApplicationJob
  queue_as :default

  # Hmmm well I can use this but I lose so many feature that come for exporting the CSV live.
  # this will
  def perform(model, serializer)
    CsvExporter.new(model, serializer).to_csv
  end
end
