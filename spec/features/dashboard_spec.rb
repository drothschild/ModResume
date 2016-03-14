require 'rails_helper'


RSpec.feature "Resumes", type: :feature, js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @resume = FactoryGirl.create(:resume)
    @resume.user = @user
    login_as(@user)
  end

  it 'can see the dashboard page & dashboard page includes user resume' do
    visit user_resumes_path(@user)
    expect(page).to have_content("ModResume")
    expect(page).to have_content(@resume.target_job)
  end

  it 'does what gary wants' do
    binding.pry
    visit user_resume_path(@user, @resume)
    expect(page).to have_content(@user.first_name)
  end

end
