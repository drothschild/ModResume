require 'rails_helper'

describe "ResumeAsset Model", model: true do
  context "Data Validation" do 
    it "has a valid factory"
    it "is invalid without a buildable type"
    it "is invalid without a user_id"
  end

  context "Associations" do 
    it "has many resumes"
    it "has many buildables"
  end
end