# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'records/edit', type: :view do
  before(:each) do
    @record = assign(:record, create(:record))
  end

  it 'renders the edit record form' do
    render

    assert_select 'form[action=?][method=?]', record_path(@record), 'post' do
      assert_select 'input[name=?]', 'record[title]'

      assert_select 'input[name=?]', 'record[year]'

      assert_select 'select[name=?]', 'record[condition]'
      assert_select 'select[name=?]', 'record[artist_id]'
    end
  end
end
