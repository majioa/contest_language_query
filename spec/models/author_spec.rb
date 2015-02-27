require 'rails_helper'

RSpec.describe Author, type: :model do
  it { should have_and_belong_to_many :languages }

  context "search by tokens" do
    let( :author_attributes ) {
      [ { name: "Name Lastname" }, { name: "Other Lastname" } ]
    }

    it "complex token" do
      authors = Author.create author_attributes
      tokens = [ 'Name Lastname' ]
      expect( Author.by_tokens tokens ).to eq( [ authors[0] ] )
    end
  end
end
