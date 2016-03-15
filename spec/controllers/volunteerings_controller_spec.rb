require 'rails_helper'

describe VolunteeringsController do


  # login_user
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in (@user)
    @volunteering = FactoryGirl.create :volunteering
    @attributes=  FactoryGirl.attributes_for :volunteering
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
  #     volunteering = FactoryGirl.create(:volunteering)
  #      volunteering.user = @user
  #      volunteering.save
  #      get :index
  #      expect(assigns (:volunteerings)).to match_array([volunteering])
  #   end

  # end

  describe "get new" do
    it "assigns a new volunteering to @volunteering" do
      get :new
      expect(assigns(:volunteering)).to be_a_new(Volunteering)
    end

    it "renders a form template" do
      get :new
      expect(response).to render_template :_form
    end
  end

  describe "get edit" do
    it "assigns requested education to @education" do
      volunteering = Volunteering.create(@attributes)
      get :edit, id: volunteering
      expect(assigns(:volunteering)).to eq volunteering
    end

    it "renders a form template" do
      volunteering = FactoryGirl.create(:volunteering)
      get :edit, id: volunteering
      expect(response).to render_template :_form
    end
  end

  describe "Post #create" do
    it "saves a valid new volunteering to the database" do

      expect{post :create, volunteering:{title: "e"}
      }.to change(Volunteering, :count).by(1)
    end

    xit "does not accept invalid parameters" do
    end

    it "returns JSON" do
      post :create, volunteering:{title: "e"}
      expect(response.content_type).to eq("application/json")

    end
  end
  describe "PUT #update" do
    let!(:new_title) {"Blergh."}

    before(:each) do
      put :update, :id => @volunteering.id, volunteering: {title: new_title}
      @volunteering.reload
    end
    it {expect(@volunteering.title).to eq (new_title)}
    it {expect(response).to render_template :_show}
  end

  describe "Delete #destroy" do
    it "decrements products by one" do
      volunteering_id = @volunteering.id
      expect{delete :destroy, id: volunteering_id}.to change {Volunteering.count}.by(-1)
   end
  it "returns nothing" do
      volunteering_id = @volunteering.id
      delete :destroy, id: volunteering_id
      expect(response.status).to eq(200)
    end
  end

end
