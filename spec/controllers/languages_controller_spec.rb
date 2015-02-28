require 'rails_helper'

RSpec.describe LanguagesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Language. As you add validations to Language, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    [ { name: "New Lang" }, { name: "Other Lang" } ]
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

  describe "GET #filter" do
    before :each do
      @languages = Language.create! valid_attributes
    end

    it "sample request" do
      get :filter, { request: '"New Lang"' }, valid_session
      expect( assigns( :languages ) ).to eq( [ @languages[0] ] )
    end

    it "omitted param :request" do
      expect{ get :filter, {}, valid_session }.to raise_error ActionController::ParameterMissing
    end

    it "reversed words request" do
      get :filter, { request: '"Lang New"' }, valid_session
      expect( assigns( :languages ) ).to eq( [ @languages[0] ] )
    end

    it "match for author 'Name Lastname'" do
      @languages[0].authors.create! author_attributes
      get :filter, { request: '"Other Lang" "Name Lastname"' }, valid_session
      expect( assigns( :languages ) ).to eq( [ @languages[ 1 ] ] )
    end

    it "match for type 'Type'" do
      @languages[0].language_types.create! type_attributes
      get :filter, { request: '"Other Lang" Type' }, valid_session
      expect( assigns( :languages ) ).to eq( [ @languages[ 1 ] ] )
    end

    it "match for author 'Name Lastname', and type 'Type'" do
      @languages[0].authors.create! author_attributes
      @languages[0].language_types.create! type_attributes
      get :filter, { request: '"Name Lastname" Type' }, valid_session
      expect( assigns( :languages ) ).to eq( [ @languages[ 0 ] ] )
    end

    it "match for author 'Name Lastname', and type not 'Type1'" do
      @languages[ 0 ].language_types.create! type_attributes
      @languages[ 1 ].language_types.create! other_type_attributes
      author = Author.create! author_attributes
      @languages[ 0 ].authors << author
      @languages[ 1 ].authors << author
      get :filter, { request: '"Name Lastname" -Type1' }, valid_session
      expect( assigns( :languages ) ).to eq( [ @languages[ 0 ] ] )
    end

  end

end
