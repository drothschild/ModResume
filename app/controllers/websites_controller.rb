class WebsitesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @new_website = Website.new(user_id: params[:user_id])
    render partial: 'form'
  end

  def create
    @website = Website.create(website_params)
    render :json => @website
  end

  def destroy
    @website = Website.find(params[:id])
    @website.destroy
    render nothing: true, status: 200, content_type: "text/html"
  end

  private

  def website_params
    params.require(:website).permit(:user_id, :url, :description)
  end

end
