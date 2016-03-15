require 'rails_helper'

describe ExperiencesController do


  # login_user
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in (@user)
    @experience = FactoryGirl.create :experience
    @attributes=  FactoryGirl.attributes_for :experience
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
  #     experience = FactoryGirl.create(:experience)
  #      experience.user = @user
  #      experience.save
  #      get :index
  #      expect(assigns (:experiences)).to match_array([experience])
  #   end

  # end

  describe "get new" do
    it "assigns a new experience to @experience" do
      get :new
      expect(assigns(:experience)).to be_a_new(Experience)
    end

    it "renders a form template" do
      get :new
      expect(response).to render_template :_form
    end
  end

  describe "get edit" do
    it "assigns requested education to @education" do
      experience = Experience.create(@attributes)
      get :edit, id: experience
      expect(assigns(:experience)).to eq experience
    end

    it "renders a form template" do
      experience = FactoryGirl.create(:experience)
      get :edit, id: experience
      expect(response).to render_template :_form
    end
  end

  describe "Post #create" do
    it "saves a valid new experience to the database" do

      expect{post :create, experience:{title: "e"}
      }.to change(Experience, :count).by(1)
    end

    xit "does not accept invalid parameters" do
    end

    it "returns JSON" do
      post :create, experience:{title: "e"}
      expect(response.content_type).to eq("application/json")

    end
  end
  describe "PUT #update" do
    let!(:new_title) {"Blergh."}

    before(:each) do
      put :update, :id => @experience.id, experience: {title: new_title}
      @experience.reload
    end
    it {expect(@experience.title).to eq (new_title)}
    it {expect(response).to render_template :_show}
  end

  describe "Delete #destroy" do
    it "decrements products by one" do
      experience_id = @experience.id
      expect{delete :destroy, id: experience_id}.to change {Experience.count}.by(-1)
   end
  it "returns nothing" do
      experience_id = @experience.id
      delete :destroy, id: experience_id
      expect(response.status).to eq(200)
    end
  end

end
