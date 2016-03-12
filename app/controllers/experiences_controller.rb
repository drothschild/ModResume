class ExperiencesController < ApplicationController
  def show
    @experience = Experience.find(params[:id])
    # render :json @experience.to_json
  end
end