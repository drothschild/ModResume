require 'rails_helper'

describe "Project Model", model: true do
  context "Data Validation" do 
    it "has a valid factory" do 
      expect(build(:project)).to be_valid
    end

    it "is invalid without a title" do 
      project = build(:project, title: nil)
      project.valid?
      expect(project.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a description" do 
      project = build(:project, description: nil)
      project.valid?
      expect(project.errors[:description]).to include("can't be blank")
    end

    it "is invalid without a user_id" do 
      project = build(:project, user_id: nil)
      project.valid?
      expect(project.errors[:user_id]).to include("can't be blank")
    end
  end

  context "Associations" do 
    before :each do
      @project = build(:project)
    end

    it "belongs to a user" do 
      expect(@project).to respond_to :user
    end

    it "belongs to resumes" do 
      expect(@project).to respond_to :resumes
    end

    it "has many describings" do 
      expect(@project).to respond_to :describings
    end

    it "has many descriptions through describings" do 
      expect(@project).to respond_to :descriptions
    end
  end
end