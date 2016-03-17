require 'rails_helper'

describe "Volunteering Model", model: true do
  context "Data Validation" do 
    it "has a valid factory" do 
      expect(build(:volunteering)).to be_valid
    end

    it "is invalid without an organization" do 
      volunteering = build(:volunteering, organization: nil)
      volunteering.valid?
      expect(volunteering.errors[:organization]).to include("can't be blank")
    end

    it "is invalid without a title" do 
      volunteering = build(:volunteering, title: nil)
      volunteering.valid?
      expect(volunteering.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a user_id" do 
      volunteering = build(:volunteering, user_id: nil)
      volunteering.valid?
      expect(volunteering.errors[:user_id]).to include("can't be blank")
    end
  end

  context "Associations" do 
    before :each do
      @volunteering = build(:volunteering)
    end

    it "belongs to a user" do 
      expect(@volunteering).to respond_to :user
    end

    it "belongs to resumes" do 
      expect(@volunteering).to respond_to :resumes
    end

    it "has many describings" do 
      expect(@volunteering).to respond_to :describings
    end

    it "has many descriptions through describings" do 
      expect(@volunteering).to respond_to :descriptions
    end
  end
end