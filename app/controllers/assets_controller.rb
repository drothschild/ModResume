class AssetsController < ApplicationController
  def index
    @objectives = Objective.all
    @skills = Skill.all
    @volunteerings = Volunteering.all
    @experiences = Experience.all
    @projects = Project.all
    @educations = Education.all
    @tags = Tag.all
  end
end
