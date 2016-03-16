class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
    @new_website = Website.new(user_id: current_user.id)
  end

end
