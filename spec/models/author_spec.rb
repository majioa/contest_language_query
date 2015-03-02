require 'rails_helper'

RSpec.describe Author, type: :model do
  it { should have_and_belong_to_many :languages }

  context "search by" do
    let( :author_attributes ) {
      [ { name: "Name Lastname" }, { name: "Other Lastone" } ]
    }

    it "complex token" do
      authors = Author.create author_attributes
      tokens = [ 'Name Lastname' ]
      expect( Author.by_tokens tokens ).to eq( [ authors[ 0 ] ] )
    end

    it "negative token" do
      authors = Author.create author_attributes
      tokens = [ '-Name' ]
      expect( Author.by_tokens tokens ).to eq( [ authors[ 1 ] ] )
    end

    it "positive and negative tokens" do
      authors = Author.create author_attributes
      tokens = [ 'Other Lastone', '-Name Lastname' ]
      expect( Author.by_tokens tokens ).to eq( [ authors[ 1 ] ] )
    end

    it "negative token with noise" do
      authors = Author.create author_attributes
      tokens = [ 'Another Lastname', '-Name Lastname' ]
      expect( Author.by_tokens tokens ).to eq( [ authors[ 1 ] ] )
    end
  end
end
