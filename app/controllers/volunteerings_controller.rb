class VolunteeringsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @volunteering = Volunteering.new
    render partial: 'form'
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
    pass_params = volunteering_params
    p "*" * 80
    p pass_params
    descriptions = pass_params.delete(:details)
    p pass_params
    p descriptions
    @volunteering = current_user.volunteerings.new(pass_params)
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
    pass_params = volunteering_params
    descriptions = pass_params.delete(:details)
    @volunteering.update(pass_params)
    addDescriptions(@volunteering, descriptions)
    redirect_to :new_user_asset
  end


  private

    def volunteering_params
      params.require(:volunteering).permit(:organization, :title, :begin_date, :end_date, :location, :details =>[:detail])
    end
    def addDescriptions(volunteering, descriptions)
      descriptions.each do |description|
        if description[:detail] != ""
          volunteering.descriptions.create(description)
        end
      end
    end
end
