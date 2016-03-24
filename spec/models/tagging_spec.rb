require 'rails_helper'

describe "Tagging Model", model: true do
  context "Data Validation" do 
  end
  
  context "Associations" do 
    before :each do 
      @tagging = build(:tagging)
    end

    it "belongs to a tag" do 
      expect(@tagging).to respond_to :tag
    end

    it "has a taggable" do 
      expect(@tagging).to respond_to :taggable
    end
  end
  
end