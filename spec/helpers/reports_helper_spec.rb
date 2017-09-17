# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReportsHelper. For example:
#
# describe ReportsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ReportsHelper, type: :helper do
  describe 'c' do
    subject { ReportsHelper::CONDITIONS_FOR_COLLECTION }
  end
end
