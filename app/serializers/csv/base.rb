# frozen_string_literal: true

module Csv
  class Base
    class << self
      attr_accessor :csv_headers
    end
    attr_accessor :record

    def initialize(record)
      # I keep forget to not use an array with this thing.
      raise 'Record is can\'t be a array' if record.is_a?(Array)
      self.record = record
    end

    def self.headers(names)
      self.csv_headers = names
      names.each do |name|
        next if self.class.instance_methods(false).include?(name.to_s)
        define_method(name) do
          record.send(name)
        end
      end
    end

    def to_a
      self.class.csv_headers.map do |header|
        send(header)
      end
    end
  end
end
