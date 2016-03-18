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
    render partial: 'form'
  end

  def edit
    @user = current_user
    @objective = Objective.find(params[:id])
    render partial: 'form'
  end

  def create
    @user = current_user
    @objective = @user.objectives.new(objective_params)
    if @objective.save
      flash[:asset_saved] = "Asset Saved. Add another?"
      @user.tags << @objective.tags
      respond_to do |format|
        format.json{render :json => {taggable_type: "objective", taggable_id: @objective.id}}
        format.html{redirect_to new_user_asset_path}
      end
    else
      flash.now[:danger] = @objective.errors.full_messages
    end
  end

  def update
    @objective = Objective.find(params[:id])
    @objective.update(objective_params)
    if @objective.save
      render partial: 'show', locals: {asset: @objective, asset_type: "objectives"}
    else
      flash.now[:danger] = @objective.errors.full_messages
      render :edit
    end
  end

  def destroy
    @objective = Objective.find(params[:id])
    @objective.destroy
    render nothing: true, status: 200, content_type: "text/html"
  end

  private

  def objective_params
    params.require(:objective).permit(:description, :tags_string)
  end
end
