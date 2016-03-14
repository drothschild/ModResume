class PrintResumes < ApplicationController
  def show
    @resume = Resume.find(params[:id])
    @user = current_user
  end
end
