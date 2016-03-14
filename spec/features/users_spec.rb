require 'rails_helper'

RSpec.feature "Users", type: :feature, js: true do

  it 'can see the welcome page' do
    visit "/"
    expect(page).to have_content("ModResume")
  end

end
