class AssetsController < ApplicationController
  def index
    @objectives = current_user.objectives
    @skills = current_user.skills
    @volunteerings = current_user.volunteerings
    @experiences = current_user.experiences
    @projects = current_user.projects
    @educations = current_user.educations
    @tags = current_user.tags
    # @assets = {Objectives: @objectives, Skills: @skills, Volunteer: @volunteerings, Experience: @experiences, Projects: @projects}
    @assets = { "objectives" => @objectives, "experiences" => @experiences, "projects" => @projects, "educations" => @educations, "skills" => @skills, "volunteerings" => @volunteerings}
  end

  def new
    @asset_types = asset_types
  end


end
