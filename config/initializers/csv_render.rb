# frozen_string_literal: true

require 'action_controller/metal/renderers'

::ActionController::Renderers.add :csv do |obj, options|
  options[:base_name] = obj.respond_to?(:model) ? obj.model.name : nil
  filename = options[:filename] || options[:base_name] # this is super helpful for changing the name
  Rails.logger.debug("[CSV OPTIONS] #{options}")
  serializer = options[:serializer] || "Csv::#{options[:base_name]}Serializer".constantize
  send_data(CsvExporter.new(obj, serializer).to_csv, type: 'text/csv', disposition: "attachment; filename=#{filename}.csv")
end
