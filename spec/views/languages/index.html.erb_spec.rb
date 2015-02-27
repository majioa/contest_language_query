require 'rails_helper'

RSpec.describe "languages/index", type: :view do
  let( :valid_attributes ) {
    [ { name: "New Lang" }, { name: "Other L" } ]
  }

  before( :each ) do
    assign( :languages, Language.create!( valid_attributes ) )
  end

  it "renders a list of languages" do
    render
    assert_select "tr>th", :text => "Name", :count => 1
    assert_select "tr>td", :text => "New Lang", :count => 1
    assert_select "tr>td", :text => "Other L", :count => 1
  end
end
