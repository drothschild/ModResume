class ObjectivesController < ApplicationController

  def index
    # @Objectives = Objective.all
    @objectives = Objective.all
  end

  def show
    @objective = Objective.find(params[:id])
    # @resume = Resume.create(target_job: "Rockstar", document_data: "Who runs the world? Squirrels!")
    # render json: @resume
  end

end
