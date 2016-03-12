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
  end

  def create
    @user = User.find(current_user.id)
    education = Education.new(education_params)
    if education.save
      @user.educations << education
      redirect_to user_educations_url
    else
      flash.now[:danger] = @education.errors.full_messages
      render :new
    end
  end

  def education_params
    params.require(:education).permit(:description, :institution_name, :location, :completion, :focus, :user_id)
  end
end
