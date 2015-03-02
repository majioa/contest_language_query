require 'rails_helper'

RSpec.describe LanguageType, type: :model do
  it { should have_and_belong_to_many :languages }

  context "search by" do
    let( :type_attributes ) {
      [ { name: "Type" }, { name: "Typo1" } ]
    }

    it "just token" do
      types = LanguageType.create type_attributes
      tokens = [ 'Type' ]
      expect( LanguageType.by_tokens tokens ).to eq( [ types[ 0 ] ] )
    end

    it "negative token" do
      types = LanguageType.create type_attributes
      tokens = [ '-Type' ]
      expect( LanguageType.by_tokens tokens ).to eq( [ types[ 1 ] ] )
    end

    it "positive and negative tokens" do
      types = LanguageType.create type_attributes
      tokens = [ 'Typo1', '-Type' ]
      expect( LanguageType.by_tokens tokens ).to eq( [ types[ 1 ] ] )
    end

    it "negative tokens with noise" do
      types = LanguageType.create type_attributes
      tokens = [ 'Typo11', '-Type' ]
      expect( LanguageType.by_tokens tokens ).to eq( [ types[ 1 ] ] )
    end
  end
end
