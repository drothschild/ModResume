require 'rails_helper'

describe "ResumeAsset Model", model: true do
  context "Data Validation" do 
    it "has a valid factory" do 
      expect(build(:resume_asset)).to be_valid
    end

    it "is invalid without a buildable type" do 
      resume_asset = build(:resume_asset, buildable_type: nil)
      resume_asset.valid?
      expect(resume_asset.errors[:buildable_type]).to include("can't be blank")
    end

    it "is invalid without a buildable id" do 
      resume_asset = build(:resume_asset, buildable_id: nil)
      resume_asset.valid?
      expect(resume_asset.errors[:buildable_id]).to include("can't be blank")
    end

    it "is invalid without a resume_id" do 
      resume_asset = build(:resume_asset, resume_id: nil)
      resume_asset.valid?
      expect(resume_asset.errors[:resume_id]).to include("can't be blank")
    end
  end

  context "Associations" do 
    before :each do
      @resume_asset = build(:resume_asset)
    end

    it "belongs to a resume" do 
      expect(@resume_asset).to respond_to(:resume)
    end

    it "has many buildables" do 
      expect(@resume_asset).to respond_to(:buildable)
    end

    it "has many descriptions" do 
      expect(@resume_asset).to respond_to(:descriptions)
    end

  end
end