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
    end
    respond_to do |format|
      format.json{render :json => {taggable_type: "Volunteering", taggable_id: @volunteering.id}}
      format.html {redirect_to new_user_asset_path}
    end

  end

  def update
    @volunteering = Volunteering.find(params[:id])
    @volunteering.descriptions.delete_all
    pass_params = volunteering_params
    detail_attributes = pass_params.delete(:details) || []
    @volunteering.update(pass_params)
    if @volunteering.save
        addDescriptions(@volunteering, detail_attributes)
    else
      flash.now[:danger] = @volunteering.errors.full_messages
    end
    render partial: 'show', locals: {asset: @volunteering, asset_type: "volunteerings", asset_descriptions: @volunteering.descriptions}
  end

  def destroy
    @volunteering = Volunteering.find(params[:id])
    @volunteering.destroy
    render nothing: true, status: 200, content_type: "text/html"
  end

  private

    def volunteering_params
      params.require(:volunteering).permit(:organization, :title, :begin_date, :end_date, :location, :details =>[:detail], :descriptions_attributes => [:detail])
    end

end
