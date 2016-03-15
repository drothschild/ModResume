class ObjectivesController < ApplicationController
  def index
    @user = current_user
    @objectives = @user.objectives
    @objective = Objective.new
  end

  def show
    @objective = Objective.find(params[:id])
  end

  def new
    @user = current_user
    @objective = Objective.new
    @tags_list = []
    render partial: 'form'
  end

  def edit
    @user = current_user
    @objective = Objective.find(params[:id])
    @tags_list = @objective.tags.order("name").map{|t| t.name}.join(", ")
    render partial: 'form'
  end

  def create
    @user = current_user
    @objective = @user.objectives.new(objective_params)
    if @objective.save
      render :json => {taggable_type: "objective", taggable_id: @objective.id}
    else
      flash.now[:danger] = @objective.errors.full_messages
      render :new
    end
  end

  def update
    @objective = Objective.find(params[:id])
    @objective.update(objective_params)
    if @objective.save
      render partial: 'show', locals: {asset: @objective, asset_type: "Objectives"}
    else
      flash.now[:danger] = @objective.errors.full_messages
      render :edit
    end
  end

  def destroy
    @objective = Objective.find(params[:id])
    @objective.delete
    render nothing: true, status: 200, content_type: "text/html"
  end

  private

  def objective_params
    params.require(:objective).permit(:description)
  end
end
