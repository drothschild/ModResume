class AssetsController < ApplicationController
  before_action :set_assets, only: [:new, :show, :create, :index, :update, :destroy]

  def index
  end

  def new
    @asset_types = asset_types
  end


  def set_assets
    @user = User.find(current_user.id)
    @objectives = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], "Objective")
    @skills = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], "Skill")
    @volunteerings = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], "Volunteering")
    @experiences = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], "Experience")
    @projects = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], "Project")
    @educations = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], "Education")
    @resume_assets = { "objectives" => @objectives, "experiences" => @experiences, "projects" => @projects, "educations" => @educations, "skills" => @skills, "volunteerings" => @volunteerings}
    @assets = @resume_assets
  end

end
