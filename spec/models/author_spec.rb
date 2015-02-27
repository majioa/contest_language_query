require 'rails_helper'

RSpec.describe Author, type: :model do
  it { should have_and_belong_to_many :languages }
end
