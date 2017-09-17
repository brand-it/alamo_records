# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'records/show', type: :view do
  before(:each) do
    @record = assign(:record, create(:record))
  end

  it 'renders attributes' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Year/)
    expect(rendered).to match(/2/)
  end
end
