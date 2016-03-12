class ExperiencesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @experience = Experience.new
    render partial: 'form'
  end


  def show
    @experience = Experience.find(params[:id])
    # render :json @experience.to_json
  end

  def create
    pass_params = experience_params
    detail_attributes = pass_params.delete(:details)
    @experience = current_user.experiences.new(pass_params)
    if @experience.save
      detail_attributes.each do |detail_attrib|
        description = @experience.descriptions.create(detail_attrib)
      end
    else
      flash.now[:danger] = @experience.errors.full_messages
      render :new
    end
    redirect_to :new_user_asset
  end

  private

    def experience_params
      params.require(:experience).permit(:company, :title, :begin_date, :end_date, :details =>[:detail])
    end
end
