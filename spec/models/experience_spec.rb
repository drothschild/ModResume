require 'rails_helper'

describe "Experience Model", model: true do
  context "Data Validation" do 
    it "has a valid factory" do 
      expect(build(:experience)).to be_valid
    end

    it "is invalid without an company" do 
      experience = build(:experience, company: nil)
      experience.valid?
      expect(experience.errors[:company]).to include("can't be blank")
    end

    it "is invalid without a title" do 
      experience = build(:experience, title: nil)
      experience.valid?
      expect(experience.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a user_id" do 
      experience = build(:experience, user_id: nil)
      experience.valid?
      expect(experience.errors[:user_id]).to include("can't be blank")
    end
  end

  context "Associations" do 
    before :each do
      @experience = build(:experience)
    end

    it "belongs to a user" do 
      expect(@experience).to respond_to :user
    end

    it "belongs to resumes" do 
      expect(@experience).to respond_to :resumes
    end

    it "has many describings" do 
      expect(@experience).to respond_to :describings
    end

    it "has many descriptions through describings" do 
      expect(@experience).to respond_to :descriptions
    end
  end
end