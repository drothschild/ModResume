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
    expect(page).to have_content(@resume.target_job)
  end

  it 'navigates to resume show page' do
    visit "/"
    fill_in "user_email", :with => @user.email
    fill_in "user_password", :with => 'password'
    click_button "Log in"
    first(:link, @resume.target_job).click
    expect(page).to have_content('#{@user.first_name}')
  end

  it 'includes option to create new resume' do
    visit "/"
    fill_in "user_email", :with => @user.email
    fill_in "user_password", :with => 'password'
    click_button "Log in"
    click_button "Add New Resume"
    expect(page).to have_selector('input[type=submit]')
  end

end
