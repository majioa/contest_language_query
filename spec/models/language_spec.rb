require 'rails_helper'

RSpec.describe Language, type: :model do
  it { should have_and_belong_to_many :language_types }
  it { should have_and_belong_to_many :authors }
end
