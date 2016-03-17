require 'rails_helper'

describe "Objective Model", model: true do
  context "Data Validation" do 
    it "has a valid factory" do 
      expect(build(:objective)).to be_valid
    end

    it "is invalid without a description" do 
      objective = build(:objective, description: nil)
      objective.valid?
      expect(objective.errors[:description]).to include("can't be blank")
    end

    it "is invalid without a user_id" do 
      objective = build(:objective, user_id: nil)
      objective.valid?
      expect(objective.errors[:user_id]).to include("can't be blank")
    end
  end

  context "Associations" do 
    before :each do
      @objective = build(:objective)
    end

    it "belongs to a user" do 
      expect(@objective).to respond_to :user
    end

    it "belongs to resumes" do 
      expect(@objective).to respond_to :resumes
    end

    it "has many describings" do 
      expect(@objective).to respond_to :describings
    end

    it "has many descriptions through describings" do 
      expect(@objective).to respond_to :descriptions
    end

  end
end