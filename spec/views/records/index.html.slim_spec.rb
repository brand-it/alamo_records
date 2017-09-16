require 'rails_helper'

RSpec.describe "records/index", type: :view do
  before(:each) do
    assign(:records, [
      Record.create!(
        :title => "Title",
        :year => "Year",
        :condition => 2
      ),
      Record.create!(
        :title => "Title",
        :year => "Year",
        :condition => 2
      )
    ])
  end

  it "renders a list of records" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Year".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
