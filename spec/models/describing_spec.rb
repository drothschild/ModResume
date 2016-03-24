require 'rails_helper'

describe "Describing Model", model: true do
  context "Data Validation" do 
  end

  context "Associations" do 
    before :each do 
      @describing = build(:describing)
    end

    it "has a description" do 
      expect(@describing).to respond_to :description
    end

    it "has a describable" do 
      expect(@describing).to respond_to :describable
    end
  end
end