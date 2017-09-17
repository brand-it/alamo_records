# frozen_string_literal: true

class Record < ApplicationRecord
  validates :title, presence: true
end
