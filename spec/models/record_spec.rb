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

require 'rails_helper'

RSpec.describe Record, type: :model do
  let(:artist_one) { create :artist }
  let(:artist_two) { create :artist }
  let(:artist_three) { create :artist }
  let(:record_one) { create :record }
  let(:record_two) { create :record }
  let(:record_three) { create :record }

  describe '.search' do
    context 'finds artist name' do
      before do
        artist_one.update!(name: 'Fitz and The Tantrums')
        artist_one.update!(name: 'Where is waldo')
        record_one.update!(artist: artist_one)
        record_two.update!(artist: artist_two)
      end
      subject { Record.search(artist_one.name) }
      it { is_expected.to include(record_one) }
      it { is_expected.to_not include(record_two) }
    end
    context 'finds title of record' do
      before do
        record_one.update!(title: 'Secrets')
        record_two.update!(title: 'Houdini')
      end
      subject { Record.search(record_one.title) }
      it { is_expected.to include(record_one) }
      it { is_expected.to_not include(record_two) }
    end

    context 'finds close matches' do
      before do
        record_one.update!(title: 'Secrets')
        record_two.update!(title: 'Houdini')
      end
      subject { Record.search('Secr') }
      it { is_expected.to include(record_one) }
      it { is_expected.to_not include(record_two) }
    end
  end
end
