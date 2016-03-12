class ResumesController < ApplicationController
  before_action :set_resume, only: [:edit, :show, :update, :destroy]
  
  def index
    if current_user
      @resumes = Resume.where(user_id: current_user.id)
    else
      # flash error please login
      redirect_to '/'
    end
  end

  def show
    # @resume = Resume.create(target_job: "Rockstar", document_data: "Who runs the world? Squirrels!")
    # render json: @resume
  end

  def new
    @tags = current_user.tags
    @resume = Resume.new()
  end

  def create
  end

  # edit html text
  def edit
    # @resume = Resume.find(params[:id])
  end

  def destroy
    @remove.destroy
    redirect_to user_resumes_path(params[:user_id])
  end

private
  def set_resume
    @resume = Resume.find(params[:id])
  end

end
