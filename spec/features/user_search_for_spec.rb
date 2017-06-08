require 'rails_helper'

feature 'User search for...' do
  given(:valid_attributes) { [ { name: "New Lang" }, { name: "Other Lang" } ] }

  given(:author_attributes) { { name: "Name Lastname" } }

  given(:type_attributes) { { name: "Type" } }

  given(:other_type_attributes) { { name: "Type1" } }

  background :each do
    languages = Language.create! valid_attributes
    languages[ 0 ].language_types.create! type_attributes
    languages[ 1 ].language_types.create! other_type_attributes
    author = Author.create! author_attributes
    languages[ 0 ].authors << author
    languages[ 1 ].authors << author
  end

  scenario 'Name Lastname and not Type1', js: true do
    visit root_path

    fill_in 'Request', with: '"Name Lastname" -Type1'

    wait_for_ajax

    expect( page ).to have_css 'td', 'New Lang'
    expect( page ).to have_no_text 'Other Lang'
  end
end
