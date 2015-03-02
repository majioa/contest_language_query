require 'rails_helper'

RSpec.describe Language, type: :model do
  it { should have_and_belong_to_many :language_types }
  it { should have_and_belong_to_many :authors }

  let( :language_attributes ) { [ { name: "Lang New" }, { name: "Other Lang" } ] }

  let( :author_attributes ) { { name: "Name Lastname" } }

  let( :type_attributes ) { { name: "Type" } }

  describe "search by" do
    before :each do
      @languages = Language.create! language_attributes
    end

    it "complex token" do
      tokens = [ 'Lang New' ]
      expect( Language.by_tokens tokens ).to eq( [ @languages[ 0 ] ] )
    end

    it "reversed words tokens" do
      tokens = [ 'New', 'Lang' ]
      expect( Language.by_tokens tokens ).to eq( @languages )
    end

    it "complex token for authors relation" do
      @languages[ 0 ].authors.create! author_attributes
      tokens = [ 'Name', 'Lastname' ]
      expect( Language.by_author_tokens tokens ).to eq( [ @languages[ 0 ] ] )
    end

    it "complex token for language_type relation" do
      @languages[ 0 ].language_types.create! type_attributes
      tokens = [ 'Type' ]
      expect( Language.by_language_type_tokens tokens ).to eq( [ @languages[ 0 ] ] )
    end

    it "complex token for both author, language_type relations" do
      @languages[ 0 ].authors.create! author_attributes
      @languages[ 0 ].language_types.create! type_attributes
      tokens = [ 'Type', 'Name', 'Lastname' ]
      expect( Language.by_tokens_with_relations tokens ).to eq( [ @languages[ 0 ] ] )
    end

    it "parted tokens with negation" do
      tokens = [ 'Lang', 'New', '-Other' ]
      expect( Language.by_tokens tokens ).to eq( [ @languages[ 0 ] ] )
    end

  end
end
