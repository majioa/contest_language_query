require "rails_helper"

RSpec.describe LanguagesController, type: :routing do
  describe "routing" do

    it "routes to root#index" do
      expect(:get => "/").to route_to("languages#index")
    end

    it "routes to #index" do
      expect(:get => "/languages").to route_to("languages#index")
    end

    it "routes to #filter" do
      expect(:get => "/filter").to route_to("languages#filter")
    end

  end
end
