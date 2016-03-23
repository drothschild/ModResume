class SkillsController < ApplicationController
  def new
    @user = current_user
    @skill = Skill.new
    @description  = Description.new
    render partial: 'form'
  end

  def edit
    @user = current_user
    @skill = Skill.find(params[:id])
    render partial: 'form'
  end

  def create
    @user = current_user
    @skill = current_user.skills.new(skill_params)
    @user.tags << @skill.tags
    @skill.save
    flash[:asset_saved] = "Asset Saved. Add another?"
    respond_to do |format|
      format.json do
        render :json => {taggable_type: "Skill", taggable_id: @skill.id}
      end
      format.html do
        redirect_to new_user_asset_path
      end
    end
  end

  def update
    @skill = Skill.find(params[:id])
    @skill.update(skill_params)
    if @skill.save
        render partial: 'show', locals: {asset: @skill, asset_type: "skills"}
    else
      flash.now[:danger] = @skill.errors.full_messages
      render :edit
    end
  end

  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy
    render nothing: true, status: 200, content_type: "text/html"
  end



private

  def skill_params
    params.require(:skill).permit(:title, :tags_string,  :details =>[:detail])
  end


end
