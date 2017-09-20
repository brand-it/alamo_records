# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CsvExporter do
  let(:artists) { create_list(:artist, 4) }
  describe '#to_csv' do
    subject { CsvExporter.new(artists, Csv::ArtistSerializer).to_csv }
    it { expect { subject }.to_not raise_error }
    it { is_expected.to match(/id,name,created_at,updated_at,total_records,first_year,last_year,common_word\n1/) }
    it { is_expected.to match(/#{artists.first.name}/) }
  end
end
