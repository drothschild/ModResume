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
        @assets["#{asset_type}"] << resume_asset
      end
    end
    # binding.pry
  end

  def new
    @user = current_user
    @tags = current_user.tags
    @new_resume = Resume.new()
    p "*" * 50
    p "NEW RESUME FORM"
    p "*" * 50
    render partial: 'form'
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
    session[:new_resume_id] = Resume.find(params[:id]).id
    redirect_to user_assets_path
    # @resume = Resume.find(params[:id])
  end

  def update
    asset_type = params[:data_asset_type].singularize.capitalize
    resume = Resume.find(params[:id])
    asset_resumes = asset_type.constantize.find(params[:data_asset_id]).resumes
    if asset_resumes.include? resume
      asset_resumes.delete resume
      update_status = "removed"
    else
      asset_resumes << resume
      update_status = "added"
    end

    p "*" * 50
    p params
    p asset_type
    p resume
    # p set_assets(resume_id: resume.id)
    p "*" * 50
    respond_to do |format|
      format.json { render json: {resume: resume, update_status: update_status}}
      format.html { p "RETURNING HTML" }

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
