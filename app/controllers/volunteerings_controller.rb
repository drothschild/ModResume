class VolunteeringsController < ApplicationController

  def new
    @user = current_user
    @volunteering = Volunteering.new
    @description  = Description.new
    @tags_list = []
    render partial: 'form'
  end

  def edit
    @user = current_user
    @volunteering = Volunteering.find(params[:id])
    @tags_list = @volunteering.tags.order("name").map{|t| t.name}.join(", ")
    render partial: 'form'
  end



  def create
    pass_params = volunteering_params
    descriptions = pass_params.delete(:details) || []
    @volunteering = current_user.volunteerings.new(pass_params)
    if @volunteering.save
      addDescriptions(@volunteering, descriptions)
    else
      flash.now[:danger] = @volunteering.errors.full_messages
      render :new
    end
    render :json => {taggable_type: "Volunteering", taggable_id: @volunteering.id}
  end

  def update
    @volunteering = Volunteering.find(params[:id])
    pass_params = volunteering_params
    detail_attributes = pass_params.delete(:details) || []
    @volunteering.update(pass_params)
    if @volunteering.save
        addDescriptions(@volunteering, detail_attributes)
    else
      flash.now[:danger] = @volunteering.errors.full_messages
      render :edit
    end
    render partial: 'show', locals: {asset: @volunteering, asset_type: "Volunteerings"}
  end

  def destroy
    @volunteering = Volunteering.find(params[:id])
    @volunteering.delete
    render nothing: true, status: 200, content_type: "text/html"
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
