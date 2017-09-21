# frozen_string_literal: true

# == Schema Information
#
# Table name: records
#
#  id         :integer          not null, primary key
#  title      :string
#  year       :integer
#  condition  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :integer
#

# TODO: UGN leanred this was songs way to late in the build I need to rename this table and model to songs
class Record < ApplicationRecord
  validates :title, presence: true
  validates :year, presence: true, numericality: { less_than_or_equal_to: Time.now.year }

  belongs_to :artist

  # TODO: this should be a service
  # There is a limitation I found with SQL Lite. You can't search enteger values
  # using the case type method. Only works in postgres sadly.
  def self.search(term)
    Record.joins(:artist).where(
      'title LIKE ? OR CAST(year AS VARCHAR(10)) LIKE ? OR artists.name LIKE ?',
      "%#{term}%", "%#{term}%", "%#{term}%"
    )
  end
end
