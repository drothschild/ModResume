class ExperiencesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @experience = Experience.new
    render partial: 'form'
  end

  def edit
    @user = User.find(params[:user_id])
    @experience = Experience.find(params[:id])
  end

  def show
    @experience = Experience.find(params[:id])
    # render :json @experience.to_json
  end

  def create
    pass_params = experience_params
    descriptions = pass_params.delete(:details)
    @experience = current_user.experiences.new(pass_params)
    if @experience.save
      addDescriptions(@experience, descriptions)
    else
      flash.now[:danger] = @experience.errors.full_messages
      render :new
    end
    redirect_to :new_user_asset
  end

  def update
    @experience = Experience.find(params[:id])
    pass_params = experience_params
    descriptions = pass_params.delete(:details)
    @experience.update(pass_params)
    addDescriptions(@experience, descriptions)
    redirect_to :new_user_asset
  end


  private

    def experience_params
      params.require(:experience).permit(:company, :title, :begin_date, :end_date, :location, :details =>[:detail])
    end
    def addDescriptions(experience, descriptions)
      descriptions.each do |description|
        if description[:detail] != ""
          experience.descriptions.create(description)
        end
      end
    end
end
