require 'rails_helper'

describe Experience do
  context "Data Validation" do 
    it "has a valid factory"
    it "is invalid without an company"
    it "is invalid without a title"
    it "is invalid without a user_id"
  end

  context "Associations" do 
    it "belongs to a user"
    it "belongs to a resume"
    it "has many describings"
    it "has many descriptions through describings"
  end
end