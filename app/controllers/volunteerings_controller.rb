class ExperiencesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @volunteering = Volunteering.new
  end

  def edit
    @user = User.find(params[:user_id])
    @volunteering = Volunteering.find(params[:id])
  end

  def show
    @volunteering = Volunteering.find(params[:id])
    # render :json @volunteering.to_json
  end

  def create
    pass_params = experience_params
    descriptions = pass_params.delete(:details)
    @volunteering = current_user.experiences.new(pass_params)
    if @volunteering.save
      addDescriptions(@volunteering, descriptions)
    else
      flash.now[:danger] = @volunteering.errors.full_messages
      render :new
    end
    redirect_to :new_user_asset
  end

  def update
    @volunteering = Volunteering.find(params[:id])
    pass_params = experience_params
    descriptions = pass_params.delete(:details)
    @volunteering.update(pass_params)
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
