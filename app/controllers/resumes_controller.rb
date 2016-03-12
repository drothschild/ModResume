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
    @resume = Resume.find(params[:id])

    asset_types


    @objectives = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], "Objective")
    @skills = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], "Skill")
    @volunteerings = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], "Volunteering")
    @experiences = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], "Experience")
    @projects = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], "Project")
    @educations = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], "Education")
    @resume_assets = { "objectives" => @objectives, "experiences" => @experiences, "projects" => @projects, "educations" => @educations, "skills" => @skills, "volunteerings" => @volunteerings}
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
