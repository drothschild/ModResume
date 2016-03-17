class ExperiencesController < ApplicationController


  def show
    @experience = Experience.find(params[:id])
    # render :json @experience.to_json
  end

  def new
    @user = current_user
    @experience = Experience.new
    @description  = Description.new
    @tags_list = []
    render partial: 'form'
  end

  def edit
    @user = current_user
    @experience = Experience.find(params[:id])
    @tags_list = @experience.tags.order("name").map{|t| t.name}.join(", ")
    render partial: 'form'
  end



  def create
    pass_params = experience_params
    descriptions = pass_params.delete(:details) || []
    @experience = current_user.experiences.new(pass_params)
    if @experience.save
      addDescriptions(@experience, descriptions)
      respond_to do |format|
        format.json{render :json => {taggable_type: "Experience", taggable_id: @experience.id}}
        format.html{redirect_to new_user_asset_path}
      end
    else
      flash.now[:danger] = @experience.errors.full_messages
      render :new
    end
  end

  def update
    @experience = Experience.find(params[:id])
    @experience.descriptions.delete_all
    pass_params = experience_params
    detail_attributes = pass_params.delete(:details) || []
    @experience.update(pass_params)
    if @experience.save
        addDescriptions(@experience, detail_attributes)
    else
      flash.now[:danger] = @experience.errors.full_messages
      render :edit
    end
    render partial: 'show', locals: {asset: @experience, asset_type: "experiences", asset_descriptions: @experience.descriptions}
  end

  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy
    render nothing: true, status: 200, content_type: "text/html"
  end

private

    def experience_params
      params.require(:experience).permit(:company, :title, :begin_date, :end_date, :location, :details =>[:detail], :descriptions_attributes => [:detail])
    end

end
