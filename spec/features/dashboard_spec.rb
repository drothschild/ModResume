require 'rails_helper'


RSpec.feature "Resumes", type: :feature, js: true do
  before(:all) do
    @user = FactoryGirl.create(:user)
    @resume = FactoryGirl.create(:resume)
    @user.save!
    @user.resumes << @resume
    @resume.save!
  end

  it 'can see the dashboard page & dashboard page includes user resume' do
    visit "/"
    fill_in "user_email", :with => @user.email
    fill_in "user_password", :with => 'password'
    click_button "Log in"
    expect(page).to have_content("ModResume")
    expect(page).to have_content(@resume.target_job)
  end


end
