class ResumesController < ApplicationController

  def index
    # @resumes = Resume.all
    @resumes = Resume.all
  end

  def show
    @resume = Resume.find(params[:id])
    @list = ["Red","Green","Blue","Yellow","Black","White","Orange"]
    # @resume = Resume.create(target_job: "Rockstar", document_data: "Who runs the world? Squirrels!")
    # render json: @resume
  end

end