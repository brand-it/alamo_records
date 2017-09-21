# frozen_string_literal: true

# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Artist < ApplicationRecord
  validates :name, presence: true
  has_many :records

  def records_per_year
    return @years if @years
    @years = {}
    records.order(year: 'asc').each do |record|
      @years[record.year] = 0 if @years[record.year].nil?
      @years[record.year] += 1
    end
    @years
  end
end
