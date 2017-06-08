require 'rails_helper'

RSpec.describe LanguagesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Language. As you add validations to Language, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    [ { name: "New Lang" }, { name: "Other Lango" } ]
  }

  let(:author_attributes) {
    { name: "Name Lastname" }
  }

  let(:type_attributes) {
    { name: "Type" }
  }

  let(:other_type_attributes) {
    { name: "Type1" }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LanguagesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all languages as @languages" do
      languages = Language.create! valid_attributes
      get :index, {}, valid_session
      expect( assigns( :languages ) ).to eq( languages )
    end
  end

  describe "POST #filter" do
    before :each do
      @languages = Language.create! valid_attributes
    end

    it "sample request" do
      post :index, { request: 'New Lang' }, valid_session
      expect( assigns( :languages ) ).to eq( @languages )
    end

    it "reversed words request" do
      post :index, { request: 'Lang New' }, valid_session
      expect( assigns( :languages ) ).to eq( [ @languages[ 0 ] ] )
    end

    it "match for author 'Name Lastname'" do
      @languages[1].authors.create! author_attributes
      post :index, { request: 'Other Lango "Name Lastname"' }, valid_session
      expect( assigns( :languages ) ).to eq( [ @languages[ 1 ] ] )
    end

    it "match for type 'Type'" do
      @languages[1].language_types.create! type_attributes
      post :index, { request: '"Other Lango" Type' }, valid_session
      expect( assigns( :languages ) ).to eq( [ @languages[ 1 ] ] )
    end

    it "match for author 'Name Lastname', and type 'Type'" do
      @languages[0].authors.create! author_attributes
      @languages[0].language_types.create! type_attributes
      post :index, { request: '"Name Lastname" Type' }, valid_session
      expect( assigns( :languages ) ).to eq( [ @languages[ 0 ] ] )
    end

    it "match for author 'Name Lastname', and type not 'Type1'" do
      @languages[ 0 ].language_types.create! type_attributes
      @languages[ 1 ].language_types.create! type_attributes
      @languages[ 1 ].language_types.create! other_type_attributes
      author = Author.create! author_attributes
      @languages[ 0 ].authors << author
      @languages[ 1 ].authors << author
      post :index, { request: '"Name Lastname" -Type1' }, valid_session
      expect( assigns( :languages ) ).to eq( [ @languages[ 0 ] ] )
    end

  end

end
