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
    @tags_list = @skill.tags.order("name").map{|t| t.name}.join(", ")
    render partial: 'form'
  end

  def create
    p skill_params
    pass_params = skill_params
    detail_attributes = pass_params.delete(:details) || []
    @skill = current_user.skills.new(pass_params)
    if @skill.save
      render :json => {taggable_type: "Skill", taggable_id: @skill.id}
    else
      flash.now[:danger] = @skill.errors.full_messages
      render :new
    end
  end

  def update
    @skill = Skill.find(params[:id])
    pass_params = skill_params
    detail_attributes = pass_params.delete(:details) || []
    @skill.update(pass_params)
    if @skill.save
        addDescriptions(@skill, detail_attributes)
        render partial: 'show', locals: {asset: @skill, asset_type: "Skills"}
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
    params.require(:skill).permit(:title, :details =>[:detail])
  end
  def addDescriptions(skill, descriptions)
    descriptions.each do |description|
      if description[:detail] != ""
        experience.descriptions.create(description)
      end
    end
  end


end
