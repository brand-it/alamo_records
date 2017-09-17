# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'records/edit', type: :view do
  before(:each) do
    @record = assign(:record, Record.create!(
                                title: 'MyString',
                                year: 'MyString',
                                condition: 1
    ))
  end

  it 'renders the edit record form' do
    render

    assert_select 'form[action=?][method=?]', record_path(@record), 'post' do
      assert_select 'input[name=?]', 'record[title]'

      assert_select 'input[name=?]', 'record[year]'

      assert_select 'input[name=?]', 'record[condition]'
    end
  end
end
