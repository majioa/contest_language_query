require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the LanguagesHelper.
RSpec.describe LanguagesHelper, type: :helper do
  describe "string concat" do
    it "parse quoted request" do
      expect(helper.tokenize('"Lisp Common"')).to eq([ "Lisp Common" ])
    end

    it "parse unquoted request" do
      expect(helper.tokenize('Scripting Microsoft')).to eq([ "Scripting", "Microsoft" ])
    end

    it "parse mixed request" do
      expect(helper.tokenize('Interpreted "Thomas Eugene"')).to eq([ "Interpreted", "Thomas Eugene" ])
    end
  end
end
