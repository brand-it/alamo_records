require 'rails_helper'

RSpec.describe "records/new", type: :view do
  before(:each) do
    assign(:record, Record.new(
      :title => "MyString",
      :year => "MyString",
      :condition => 1
    ))
  end

  it "renders new record form" do
    render

    assert_select "form[action=?][method=?]", records_path, "post" do

      assert_select "input[name=?]", "record[title]"

      assert_select "input[name=?]", "record[year]"

      assert_select "input[name=?]", "record[condition]"
    end
  end
end
