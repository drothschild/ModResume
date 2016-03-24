require 'rails_helper'

describe "Education Model", model: true do
  context "Data Validation" do 
    it "has a valid factory" do 
      expect(build(:education)).to be_valid
    end

    it "is invalid without an institution name" do 
      education = build(:education, institution_name: nil)
      education.valid?
      expect(education.errors[:institution_name]).to include("can't be blank")
    end

    it "is invalid without a user_id" do 
      education = build(:education, user_id: nil)
      education.valid?
      expect(education.errors[:user_id]).to include("can't be blank")
    end
  end

  context "Associations" do 
    before :each do
      @education = build(:education)
    end

    it "belongs to a user" do 
      expect(@education).to respond_to :user
    end

    it "belongs to resumes" do 
      expect(@education).to respond_to :resumes
    end

    it "has many describings" do 
      expect(@education).to respond_to :describings
    end

    it "has many descriptions through describings" do 
      expect(@education).to respond_to :descriptions
    end

  end
end