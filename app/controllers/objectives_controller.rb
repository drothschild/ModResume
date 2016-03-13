class ObjectivesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @objectives = @user.objectives
    @objective = Objective.new
  end

  def show
    @objective = Objective.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @objective = Objective.new
    render partial: 'form'
  end

  def create
    p "*"* 80
    p params
    @user = User.find(params[:user_id])
    @objective = @user.objectives.new(objective_params)
    if @objective.save
      render :json => {taggable_type: "objective", taggable_id: @objective.id}
    else
      flash.now[:danger] = @objective.errors.full_messages
      render :new
    end
  end

  def objective_params
    params.require(:objective).permit(:description)
  end
end
