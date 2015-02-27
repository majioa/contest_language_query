require 'rails_helper'

RSpec.describe LanguageType, type: :model do
  it { should have_and_belong_to_many :languages }
end
