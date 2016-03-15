require 'rails_helper'

describe EducationsController do
  # login_user
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in (@user)
  end

  it "should have a current_user" do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect(subject.current_user).to_not eq(nil)
  end


  describe "GET Index" do
    @education = FactoryGirl.create :education
     @attributes=  FactoryGirl.attributes_for :education

    it "should display an index" do
      get :index
      expect(response).to be_success
    end
    it "should have some items on the index" do
      education = FactoryGirl.create(:education)
       education.user = @user
       education.save
       p education
       get :index
       expect(assigns (:educations)).to match_array([education])
    end

  end

  describe "get new" do
    it "assigns a new education to @education" do
      get :new
      expect(assigns(:education)).to be_a_new(Education)
    end

    it "renders a form template" do
      get :new
      expect(response).to render_template :_form
    end
  end

  describe "get edit" do
    it "assigns requested education to @education" do
      education = Education.create(@attributes)
      get :edit, id: education
      expect(assigns(:education)).to eq education
    end

    it "renders a form template" do
      education = FactoryGirl.create(:education)
      get :edit, id: education
      expect(response).to render_template :_form
    end
  end

  describe "Post #create" do
    it "saves a valid new education to the database" do

      expect{post :create, education:{institution_name: "e"}
      }.to change(Education, :count).by(1)
    end
  end


end
