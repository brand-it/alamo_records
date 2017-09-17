# frozen_string_literal: true

class Record < ApplicationRecord
  validates :title, presence: true
  validates :year, presence: true, numericality: { less_than_or_equal_to: Time.now.year }
end
