class ExperiencesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @experience = Experience.new
  end


  def show
    @experience = Experience.find(params[:id])
    # render :json @experience.to_json
  end

  def create
    pass_params = experience_params
    detail_attributes = pass_params.delete(:details)
    @experience = current_user.experiences.create(pass_params)
    detail_attributes.each do |detail_attrib|
      description = @experience.descriptions.create(detail_attrib)
    end
    redirect_to :new_user_asset
  end

  private

    def experience_params
      params.require(:experience).permit(:company, :title, :begin_date, :end_date, :details =>[:detail])
    end
end
