require 'rails_helper'

describe SkillsController do
  # login_user
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in (@user)
    @skill = FactoryGirl.create :skill
    @attributes=  FactoryGirl.attributes_for :skill
  end

  it "should have a current_user" do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect(subject.current_user).to_not eq(nil)
  end


  # describe "GET Index" do

  #   it "should display an index" do
  #     get :index
  #     expect(response).to be_success
  #   end
  #   it "should have some items on the index" do
  #     skill = FactoryGirl.create(:skill)
  #      skill.user = @user
  #      skill.save
  #      get :index
  #      expect(assigns (:skills)).to match_array([skill])
  #   end

  # end

  describe "get new" do
    it "assigns a new skill to @skill" do
      get :new
      expect(assigns(:skill)).to be_a_new(Skill)
    end

    it "renders a form template" do
      get :new
      expect(response).to render_template :_form
    end
  end

  describe "get edit" do
    it "assigns requested skills to @skill" do
      skill = Skill.create(@attributes)
      get :edit, id: skill
      expect(assigns(:skill)).to eq skill
    end

    it "renders a form template" do
      skill = FactoryGirl.create(:skill)
      get :edit, id: skill
      expect(response).to render_template :_form
    end
  end

  describe "Post #create" do
    it "saves a valid new skill to the database" do

      expect{post :create, skill:{title: "e"}
      }.to change(Skill, :count).by(1)
    end

    xit "does not accept invalid parameters" do
    end

    it "returns JSON" do
      post :create, skill:{title: "e"}
      expect(response.content_type).to eq("application/json")

    end
  end
  describe "PUT #update" do
    let!(:new_title) {"Blergh."}

    before(:each) do
      put :update, :id => @skill.id, skill: {title: new_title}
      @skill.reload
    end
    it {expect(@skill.title).to eq (new_title)}
    it {expect(response).to render_template :_show}
  end

  describe "Delete #destroy" do
    it "decrements products by one" do
      skill_id = @skill.id
      expect{delete :destroy, id: skill_id}.to change {Skill.count}.by(-1)
   end
  it "returns nothing" do
      skill_id = @skill.id
      delete :destroy, id: skill_id
      expect(response.status).to eq(200)
    end
  end

end
