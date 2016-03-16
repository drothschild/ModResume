class UsersController < ApplicationController
  skip_before_action :require_login
  def show
    @user = User.find(current_user.id)
    @new_website = Website.new(user_id: current_user.id)
  end

end
