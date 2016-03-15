require 'rails_helper'

describe ProjectsController do
  # login_user
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in (@user)
    @project = FactoryGirl.create :project
    @attributes=  FactoryGirl.attributes_for :project
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
  #     project = FactoryGirl.create(:project)
  #      project.user = @user
  #      project.save
  #      get :index
  #      expect(assigns (:projects)).to match_array([project])
  #   end

  # end

  describe "get new" do
    it "assigns a new project to @project" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end

    it "renders a form template" do
      get :new
      expect(response).to render_template :_form
    end
  end

  describe "get edit" do
    it "assigns requested education to @education" do
      project = Project.create(@attributes)
      get :edit, id: project
      expect(assigns(:project)).to eq project
    end

    it "renders a form template" do
      project = FactoryGirl.create(:project)
      get :edit, id: project
      expect(response).to render_template :_form
    end
  end

  describe "Post #create" do
    it "saves a valid new project to the database" do

      expect{post :create, project:{description: "e"}
      }.to change(Project, :count).by(1)
    end

    xit "does not accept invalid parameters" do
    end

    it "returns JSON" do
      post :create, project:{description: "e"}
      expect(response.content_type).to eq("application/json")

    end
  end
  describe "PUT #update" do
    let!(:new_title) {"Blergh."}

    before(:each) do
      put :update, :id => @project.id, project: {description: new_title}
      @project.reload
    end
    it {expect(@project.description).to eq (new_title)}
    it {expect(response).to render_template :_show}
  end

  describe "Delete #destroy" do
    it "decrements products by one" do
      project_id = @project.id
      expect{delete :destroy, id: project_id}.to change {Project.count}.by(-1)
   end
  it "returns nothing" do
      project_id = @project.id
      delete :destroy, id: project_id
      expect(response.status).to eq(200)
    end
  end

end
