# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#export_csv' do
    subject { export_csv(Artist) }
    it { expect { subject }.to_not raise_error }
  end
end
