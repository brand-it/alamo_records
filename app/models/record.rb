class Record < ApplicationRecord
  validates :title, presence: true
end
