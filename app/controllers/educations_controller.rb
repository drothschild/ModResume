class EducationsController < ApplicationController
  def index

    @user = User.find(current_user.id)
    @educations = @user.educations
  end

  def show
    @education = Education.find(params[:id])
  end

  def new
    @user = User.find(current_user.id)
    @education = Education.new
    @description  = Description.new
    @tags_list = []
    render partial: 'form'
  end

  def edit
    @education = Education.find(params[:id])
    @user = User.find(current_user.id)
    @tags_list = @education.tags.order("name").map{|t| t.name}.join(", ")
    render partial: 'form'
  end

  def create

    pass_params = education_params
    detail_attributes = pass_params.delete(:details) || []
    @education = current_user.educations.new(pass_params)
    if @education.save
      detail_attributes.each do |detail_attrib|
        description = @education.descriptions.create(detail_attrib)
      end
    else
      flash.now[:danger] = @education.errors.full_messages
      render :new
    end
    render :json => {taggable_type: "Education", taggable_id: @education.id}
  end

  def update
    @education = Education.find(params[:id])
    pass_params = education_params
    detail_attributes = pass_params.delete(:details) || []
    @education.update(pass_params)
    if @education.save
      @education.descriptions.delete_all
      detail_attributes.each do |detail_attrib|
        if detail_attrib != ""
          description = @education.descriptions.create(detail_attrib)
        end
      end
    else
      flash.now[:danger] = @education.errors.full_messages
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
    params.require(:education).permit(:description, :institution_name, :location, :completion, :focus, :details =>[:detail])
  end

end
