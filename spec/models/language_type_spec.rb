require 'rails_helper'

RSpec.describe LanguageType, type: :model do
  it { should have_and_belong_to_many :languages }

  context "search by tokens" do
    let( :type_attributes ) {
      [ { name: "Type" }, { name: "Type1" } ]
    }

    it "complex token" do
      types = LanguageType.create type_attributes
      tokens = [ 'Type' ]
      expect( LanguageType.by_tokens tokens ).to eq( [ types[0] ] )
    end
  end
end
