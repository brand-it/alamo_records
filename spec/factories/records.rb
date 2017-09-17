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

FactoryGirl.define do
  factory :record do
    title { Faker::Name.name }
    year { Time.now.year - 1 }
    condition { (1...11).to_a.sample }
    artist { create :artist }
  end
end
