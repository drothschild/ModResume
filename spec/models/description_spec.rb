require 'rails_helper'

describe "Description Model", model: true do
  context "Data Validation" do 
    it "has a valid factory" do 
      expect(build(:description)).to be_valid
    end

    it "is invalid without a detail" do 
      description = build(:description, detail: nil)
      description.valid?
      expect(description.errors[:detail]).to include("can't be blank")
    end
  end

  context "Associations" do 
    before :each do
      @description = build(:description)
    end

    it "has many describings" do 
      expect(@description).to respond_to :describings
    end

  end
end