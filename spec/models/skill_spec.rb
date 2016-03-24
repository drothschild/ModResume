require 'rails_helper'

describe "Skill Model", model: true do
  context "Data Validation" do 
    it "has a valid factory" do 
      expect(build(:skill)).to be_valid
    end

    it "is invalid without a title" do 
      skill = build(:skill, title: nil)
      skill.valid?
      expect(skill.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a user_id" do 
      skill = build(:skill, user_id: nil)
      skill.valid?
      expect(skill.errors[:user_id]).to include("can't be blank")
    end
  end

  context "Associations" do 
    before :each do
      @skill = build(:skill)
    end

    it "belongs to a user" do 
      expect(@skill).to respond_to :user
    end

    it "belongs to resumes" do 
      expect(@skill).to respond_to :resumes
    end

    it "has many describings" do 
      expect(@skill).to respond_to :describings
    end

    it "has many descriptions through describings" do 
      expect(@skill).to respond_to :descriptions
    end

  end
end