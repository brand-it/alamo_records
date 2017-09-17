# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'records/index', type: :view do
  before(:each) do
    assign(:records, create_list(:record, 2, title: 'Title', year: 2000, condition: 2))
  end

  it 'renders a list of records' do
    render
    assert_select 'tr>td', text: 'Title', count: 2
    assert_select 'tr>td', text: '2000', count: 2
    assert_select 'tr>td', text: '2', count: 2
  end
end
