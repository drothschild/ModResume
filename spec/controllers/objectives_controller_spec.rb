require 'rails_helper'

describe ObjectivesController do
  # login_user
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in (@user)
    @objective = FactoryGirl.create :objective
    @attributes=  FactoryGirl.attributes_for :objective
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
  #     objective = FactoryGirl.create(:objective)
  #      objective.user = @user
  #      objective.save
  #      get :index
  #      expect(assigns (:objectives)).to match_array([objective])
  #   end

  # end

  describe "get new" do
    it "assigns a new objective to @objective" do
      get :new
      expect(assigns(:objective)).to be_a_new(Objective)
    end

    it "renders a form template" do
      get :new
      expect(response).to render_template :_form
    end
  end

  describe "get edit" do
    it "assigns requested education to @education" do
      objective = Objective.create(@attributes)
      get :edit, id: objective
      expect(assigns(:objective)).to eq objective
    end

    it "renders a form template" do
      objective = FactoryGirl.create(:objective)
      get :edit, id: objective
      expect(response).to render_template :_form
    end
  end

  describe "Post #create" do
    it "saves a valid new objective to the database" do

      expect{post :create, objective:{description: "e"}
      }.to change(Objective, :count).by(1)
    end

    xit "does not accept invalid parameters" do
    end

    it "returns JSON" do
      post :create, objective:{description: "e"}
      expect(response.content_type).to eq("application/json")

    end
  end
  describe "PUT #update" do
    let!(:new_title) {"Blergh."}

    before(:each) do
      put :update, :id => @objective.id, objective: {description: new_title}
      @objective.reload
    end
    it {expect(@objective.description).to eq (new_title)}
    it {expect(response).to render_template :_show}
  end

  describe "Delete #destroy" do
    it "decrements products by one" do
      objective_id = @objective.id
      expect{delete :destroy, id: objective_id}.to change {Objective.count}.by(-1)
   end
  it "returns nothing" do
      objective_id = @objective.id
      delete :destroy, id: objective_id
      expect(response.status).to eq(200)
    end
  end

end
