# frozen_string_literal: true

module Csv
  class ArtistSerializer < Base
    headers Artist.columns.map(&:name).push(:total_records, :first_year, :last_year, :common_word)
    # you can define what ever you feel like that need to be exported to CSV.
    def total_records
      record.records.count
    end

    # ung this is not a greate name for this
    def first_year
      record.records.order(:year).first&.year
    end

    # ung this is not a greate name for this
    def last_year
      record.records.order(:year).last&.year
    end

    # this is not very fast but it works. It will take more time to make this code faster
    # TODO: Make more gooder....
    def common_word
      words = {}
      record.records.each do |record|
        record.title.split(' ').each do |word|
          words[word] = 0 if words[word].nil?
          words[word] += 1
        end
      end
      return if words.empty?
      words.sort.first[0]
    end
  end
end
