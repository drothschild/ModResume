require 'rails_helper'

RSpec.feature "Resumes", type: :feature, js: true do
  before(:all) do
    @user = FactoryGirl.create(:user)
    @resume = FactoryGirl.create(:resume)
    @experience = FactoryGirl.create(:experience)
    @education = FactoryGirl.create(:education)
    @user.save!
    @user.resumes << @resume
    ResumeAsset.create(resume_id: @resume.id, buildable_id: @experience.id, buildable_type: 'Experience')
    ResumeAsset.create(resume_id: @resume.id, buildable_id: @education.id, buildable_type: 'Education')

    @resume.save!
  end

    it 'should see a list of current experience on resume' do
      visit '/'
      fill_in "user_email", :with => @user.email
      fill_in "user_password", :with => 'password'
      click_button "Log in"
      first(:link, @resume.target_job).click
      # binding.pry
      expect(page).to have_content(@experience.title)
      expect(page).to have_content(@experience.company)
      expect(page).to have_content(@experience.location)
    end

    it 'should see a list of current education on resume' do
      visit '/'
      fill_in "user_email", :with => @user.email
      fill_in "user_password", :with => 'password'
      click_button "Log in"
      first(:link, @resume.target_job).click
      # binding.pry
      expect(page).to have_content(@education.institution_name)
      expect(page).to have_content(@education.focus)
    end

    it 'should be able to drag a DOM item to the middle section' do
      visit '/'
      fill_in "user_email", :with => @user.email
      fill_in "user_password", :with => 'password'
      click_button "Log in"
      first(:link, @resume.target_job).click
      draggable_item = page.find_by_id('Experience_1').find(:xpath, '../..')
      target = page.first('#divSection_2')
      draggable_item.drag_to(target)
    end

    it 'should be able to drag a second DOM item into the middle section' do
      visit '/'
      fill_in "user_email", :with => @user.email
      fill_in "user_password", :with => 'password'
      click_button "Log in"
      first(:link, @resume.target_job).click
      draggable_item = page.find_by_id('Education_1').find(:xpath, '../..')
      target = page.first('#divSection_3')
      draggable_item.drag_to(target)
    end

end
