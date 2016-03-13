class ResumesController < ApplicationController
  before_action :set_resume, only: [:edit, :show, :update, :destroy]

  def index
    if current_user
      @resumes = Resume.where(user_id: current_user.id)
      @user = current_user
      @new_resume = Resume.new
    else
      # flash error please login
      redirect_to '/'
    end
  end

  def show
    @tags = Tag.all
    @resume = Resume.find(params[:id])
    @assets = {}
    @asset_types = asset_types

    @asset_types.each do |asset_type|
      @assets["#{asset_type}"] = []
      resume_assets = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], asset_type.capitalize.singularize)
      resume_assets.each do |resume_asset|
        @assets["#{asset_type}"] << resume_asset.buildable
      end
    end
  end

  def new
    @user = current_user
    @tags = current_user.tags
    @new_resume = Resume.new()
  end

  def create
    p "*" * 50
    p params
    p "*" * 50
    pass_params = resume_params
    @new_resume = Resume.new(pass_params)
    if @new_resume.save
      session[:new_resume_id] = @new_resume.id
      redirect_to user_assets_path
    end
  end

  # edit html text
  def edit
    # @resume = Resume.find(params[:id])
  end

  def update
    asset_type = params[:data_asset_type].singularize.capitalize
    resume = Resume.find(params[:id])
    asset_type.constantize.find(params[:data_asset_id]).resumes << resume 
    p "*" * 50
    p params
    p asset_type
    p resume
    p "*" * 50
    if request.xhr?
      201
      # render :json resume.to_json
    else
      redirect_to user_assets_path
    end

  end

  def destroy
    @remove.destroy
    redirect_to user_resumes_path(params[:user_id])
  end

private
  def set_resume
    @resume = Resume.find(params[:id])
  end

  def resume_params
    params.require(:resume).permit(:user_id, :target_job)
  end

end
