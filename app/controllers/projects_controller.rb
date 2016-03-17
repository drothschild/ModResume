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
    @tags_list = ""
    render partial: 'form'
  end

  def edit
    @project = Project.find(params[:id])
    @user = User.find(current_user.id)
    @tags_list = @project.tags.order("name").map{|t| t.name}.join(", ")
    render partial: 'form'
  end


  def create
    p project_params
    pass_params = project_params
    detail_attributes = pass_params.delete(:details) || []
    @project = current_user.projects.new(pass_params)
    if @project.save
      detail_attributes.each do |detail_attrib|
        description = @project.descriptions.create(detail_attrib)
      end
    else
      flash.now[:danger] = @project.errors.full_messages
      render :new
    end
    render :json => {taggable_type: "projects", taggable_id: @project.id}
  end

  def update
    @project = Project.find(params[:id])
    pass_params = project_params
    detail_attributes = pass_params.delete(:details) || []
    @project.update(pass_params)
    if @project.save
      @project.descriptions.delete_all
      detail_attributes.each do |detail_attrib|
        if detail_attrib != ""
          description = @project.descriptions.create(detail_attrib)
        end
      end
    else
      flash.now[:danger] = @project.errors.full_messages
      render :edit
    end
    render partial: 'show', locals: {asset: @project, asset_type: "projects", asset_descriptions: @project.descriptions}
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    render nothing: true, status: 200, content_type: "text/html"
  end

  def project_params
    params.require(:project).permit(:description, :title, :details =>[:detail], :descriptions_attributes => [:detail])
  end
end
