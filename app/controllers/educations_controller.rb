class EducationsController < ApplicationController

  def show
    @education = Education.find(params[:id])
  end

  def new
    @user = current_user
    @education = Education.new
    @description  = Description.new
    @tags_list = []
    render partial: 'form'
  end

  def edit
    @education = Education.find(params[:id])
    @user = current_user
    @tags_list = @education.tags.order("name").map{|t| t.name}.join(", ")
    render partial: 'form'
  end

  def create
    @user = current_user
    pass_params = education_params
    detail_attributes = pass_params.delete(:details) || []
    @education = current_user.educations.new(pass_params)
    if @education.save
      flash[:asset_saved] = "Asset Saved. Add another?"
      @user.tags << @education.tags
      addDescriptions(@education, detail_attributes)
      respond_to do |format|
        format.json{render :json => {taggable_type: "Education", taggable_id: @education.id}}
        format.html{redirect_to new_user_asset_path}
      end
    else
      flash.now[:notice] = @education.errors.full_messages

    end
  end

  def update
    @education = Education.find(params[:id])
    @education.descriptions.delete_all
    pass_params = education_params
    detail_attributes = pass_params.delete(:details) || []
    @education.update(pass_params)
    if @education.save
      addDescriptions(@education, detail_attributes)
    else
      flash.now[:notice] = @education.errors.full_messages
      render :edit
    end
    render partial: 'show', locals: {asset: @education, asset_type: "educations", asset_descriptions: @education.descriptions}
  end

  def destroy
    @education = Education.find(params[:id])
    @education.destroy
    render nothing: true, status: 200, content_type: "text/html"
  end

  private

  def education_params
    params.require(:education).permit(:description, :institution_name, :location, :completion, :tags_string, :focus, :details =>[:detail], :descriptions_attributes => [:detail])
  end

end
