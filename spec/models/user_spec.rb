require 'rails_helper'

describe "User Model", model: true do
  context "Data Validation" do 
    it "has a valid factory" do 
      expect(build(:user)).to be_valid
    end

    it "is invalid without a first_name" do 
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a last_name" do 
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "is invalid without an email" do 
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a phone_number" do 
      user = build(:user, phone_number: nil)
      user.valid?
      expect(user.errors[:phone_number]).to include("can't be blank")
    end

    it "is invalid without a password" do 
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid with a short password" do 
      user = build(:user, password: "a")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end

    it "is invalid with a duplicate email address" do
      user1 = create(:user, email: "test@test.com")
      user2 = build(:user, email: "test@test.com")
      user2.valid?
      expect(user2.errors[:email]).to include("has already been taken")
    end
  end

  context "Associations" do 
    before :each do
      @user = build(:user)
    end

    it "has many websites" do 
      expect(@user).to respond_to :websites
    end

    it "has many tags" do 
      expect(@user).to respond_to :tags
    end

    it "has many resumes" do 
      expect(@user).to respond_to :resumes
    end

    it "has many experiences" do 
      expect(@user).to respond_to :experiences
    end

    it "has many objectives" do 
      expect(@user).to respond_to :objectives
    end

    it "has many volunteerings" do 
      expect(@user).to respond_to :volunteerings
    end

    it "has many skills" do 
      expect(@user).to respond_to :skills
    end

    it "has many projects" do 
      expect(@user).to respond_to :projects
    end

    it "has many educations" do 
      expect(@user).to respond_to :educations
    end

  end
end