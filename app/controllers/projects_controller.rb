class ProjectsController < ApplicationController
  def index

    @user = User.find(current_user.id)
    @projects = @user.projects
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @user = User.find(current_user.id)
    @project = Project.new
    @description  = Description.new
    render partial: 'form'
  end

  def edit
    @project = Project.find(params[:id])
    @user = User.find(current_user.id)
    render partial: 'form'
  end


  def create
    p project_params
    pass_params = project_params
    detail_attributes = pass_params.delete(:details)
    @project = current_user.projects.new(pass_params)
    if @project.save
      detail_attributes.each do |detail_attrib|
        description = @project.descriptions.create(detail_attrib)
      end
    else
      flash.now[:danger] = @project.errors.full_messages
      render :new
    end
    redirect_to :new_user_asset
  end

  def create
    p project_params
    pass_params = project_params
    detail_attributes = pass_params.delete(:details)
    @project = current_user.projects.update(pass_params)
    if @project.save
      detail_attributes.each do |detail_attrib|
        description = @project.descriptions.create(detail_attrib)
      end
    else
      flash.now[:danger] = @project.errors.full_messages
      render :edit
    end
    redirect_to :new_user_asset
  end

  def project_params
    params.require(:project).permit(:description, :title, :details =>[:detail])
  end
end
