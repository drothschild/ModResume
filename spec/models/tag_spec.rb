require 'rails_helper'

describe "Tag Model", model: true do
  before :each do 
    @tag = build(:tag)
    @user1 = create(:user)
    @user2 = create(:user)
  end

  context "Data Validation" do 
    it "has a valid factory" do 
      expect(@tag).to be_valid
    end

    it "is invalid without a name" do 
      tag = build(:tag, name: nil)
      tag.valid?
      expect(tag.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a duplicate name per user" do
      tag = create(:tag, user: @user1)
      tag2 = build(:tag, user: @user1)

      tag2.valid?
      expect(tag2.errors[:name]).to include("has already been taken")
    end

    it "allows duplicate names across different users" do
      tag1 = create(:tag, user: @user1)
      tag2 = build(:tag, user: @user2)

      tag2.valid?
      expect(tag2).to be_valid
    end
  end

  context "Associations" do 
    it "has many taggings" do 
      expect(@tag).to respond_to :taggings
    end

    it "has many experiences through taggings" do 
      expect(@tag).to respond_to :experiences
    end

    it "has many objectives through taggings" do 
      expect(@tag).to respond_to :objectives
    end

    it "has many skills through taggings" do 
      expect(@tag).to respond_to :skills
    end

    it "has many volunteerings through taggings" do 
      expect(@tag).to respond_to :volunteerings
    end

    it "has many projects through taggings" do 
      expect(@tag).to respond_to :projects
    end

    it "has many educations through taggings" do 
      expect(@tag).to respond_to :educations
    end
  end
end

