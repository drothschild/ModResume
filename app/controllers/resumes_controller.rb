class ResumesController < ApplicationController

  def index
    # @resumes = Resume.all
    if current_user
      @resumes = Resume.where(user_id: current_user.id)
    else
      # flash error please login
      redirect_to '/'
    end
  end

  def show
    @resume = Resume.find(params[:id])
    @list = ["Red","Green","Blue","Yellow","Black","White","Orange"]
    # @resume = Resume.create(target_job: "Rockstar", document_data: "Who runs the world? Squirrels!")
    # render json: @resume
  end

end
