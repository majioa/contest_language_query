require 'rails_helper'

RSpec.describe Language, type: :model do
  it { should have_and_belong_to_many :language_types }
  it { should have_and_belong_to_many :authors }

  let( :language_attributes ) {
    [ { name: "Lang New" }, { name: "Other Lang" } ]
  }

  let( :author_attributes ) {
    { name: "Name Lastname" }
  }

  let( :type_attributes ) {
    { name: "Type" }
  }

  describe "search by tokens" do
    before :each do
      @languages = Language.create! language_attributes
    end

    it "complex token" do
      tokens = [ 'Lang New' ]
      expect( Language.by_tokens tokens ).to eq( [ @languages[0] ] )
    end

    it "complex reversed words token" do
      tokens = [ 'New Lang' ]
      expect( Language.by_tokens tokens ).to eq( [ @languages[0] ] )
    end

    it "complex token for authors relation" do
      @languages[0].authors.create! author_attributes
      tokens = [ 'Name Lastname' ]
      expect( Language.by_author_tokens tokens ).to eq( [ @languages[0] ] )
    end

    it "complex token for language_type relation" do
      @languages[0].language_types.create! type_attributes
      tokens = [ 'Type' ]
      expect( Language.by_language_type_tokens tokens ).to eq( [ @languages[0] ] )
    end
  end
end
