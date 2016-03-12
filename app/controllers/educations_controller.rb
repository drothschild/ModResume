class EducationsController < AssetsController
  def index

    @user = User.find(current_user.id)
    @educations = @user.educations
  end

  def show
    @education = Education.find(params[:id])
  end

  def new
    @education = Education.new
  end

  def create
    super
    education = @user.educations.new(education_params)
    if education.save
      redirect_to [@user, @user.educations]
    else
      flash.now[:danger] = @education.errors.full_messages
      render :new
    end
  end

  def education_params
    params.require(:education).permit(:description)
  end
end
