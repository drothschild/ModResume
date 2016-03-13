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
    render partial: 'form'
  end

  def create

    pass_params = education_params
    detail_attributes = pass_params.delete(:details)
    @education = current_user.educations.new(pass_params)
    if @education.save
      detail_attributes.each do |detail_attrib|
        description = @education.descriptions.create(detail_attrib)
      end
    else
      flash.now[:danger] = @education.errors.full_messages
      render :new
    end
    redirect_to :new_user_asset
  end

  def education_params
    params.require(:education).permit(:description, :institution_name, :location, :completion, :focus, :details =>[:detail])
  end
end
