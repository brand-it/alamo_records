# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Csv::ArtistSerializer do
  let(:artist) { create :artist }
  let(:record) { create :record, artist: artist }
  describe '#name' do
    subject { Csv::ArtistSerializer.new(artist).name }
    it { is_expected.to eq artist.name }
  end

  describe '#total_records' do
    before { record } # Lets create that new record
    subject { Csv::ArtistSerializer.new(artist).total_records }
    it { is_expected.to eq(1) }
  end
end
