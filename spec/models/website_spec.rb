require 'rails_helper'

describe Website do
  before :each do 
    @user1 = create(:user)
    @user2 = create(:user)
  end

  context "Data Validation" do 
    it "has a valid factory" do 
      website = build(:website)
      expect(website).to be_valid
    end

    it "is invalid without a description" do 
      website = build(:website, description: nil)
      website.valid?
      expect(website.errors[:description]).to include("can't be blank")
    end

    it "is invalid without a url" do 
      website = build(:website, url: nil)
      website.valid?
      expect(website.errors[:url]).to include("can't be blank")
    end

    it "is invalid without a user_id" do 
      website = build(:website, user_id: nil)
      website.valid?
      expect(website.errors[:user_id]).to include("can't be blank")
    end

    it "is invalid with a duplicate url per user" do
      website = create(:website, user: @user1)
      website2 = build(:website, user: @user1)
      # website = create(:website, user_id: 1)
      # website2 = build(:website, user_id: 1)

      website2.valid?
      expect(website2.errors[:url]).to include("has already been taken")
    end

    it "allows two users to share a website url" do
      website1 = create(:website, user: @user1)
      website2 = build(:website, user: @user2)

      website2.valid?
      expect(website2).to be_valid
    end
  end

  context "Associations" do 
    it "belongs to a user" do 
      expect(build(:website)).to respond_to :user
    end
  end
end