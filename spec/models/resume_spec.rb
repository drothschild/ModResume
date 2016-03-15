require 'rails_helper'

describe "Resume Model", model: true do
  before :each do 
    @resume = build(:resume)
  end

  context "Data Validation" do 
    it "has a valid factory" do 
      # resume = build(:resume)
      expect(@resume).to be_valid
    end

    it "is invalid without a taget_job" do 
      resume = build(:resume, target_job: nil)
      resume.valid?
      expect(resume.errors[:target_job]).to include("can't be blank")
    end
  end

  context "Associations" do 
    it "belongs to a user" do 
      expect(@resume).to respond_to :user
    end

    it "has many tags" do 
      expect(@resume).to respond_to :tags
    end

    it "has many taggings" do 
      expect(@resume).to respond_to :taggings
    end

    it "has many resume_assets" do 
      expect(@resume).to respond_to :resume_assets
    end

    it "has many experiences through resume_assets" do 
      expect(@resume).to respond_to :experiences
    end

    it "has many objectives through resume_assets" do 
      expect(@resume).to respond_to :objectives
    end

    it "has many skills through resume_assets" do 
      expect(@resume).to respond_to :skills
    end

    it "has many volunteerings through resume_assets" do 
      expect(@resume).to respond_to :volunteerings
    end

    it "has many projects through resume_assets" do 
      expect(@resume).to respond_to :projects
    end

    it "has many educations through resume_assets" do 
      expect(@resume).to respond_to :educations
    end
  end






end