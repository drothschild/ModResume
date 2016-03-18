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
    @user = current_user
    pass_params = project_params
    detail_attributes = pass_params.delete(:details) || []
    @project = current_user.projects.new(pass_params)
    if @project.save
      @user.tags << @project.tags
      addDescriptions(@project, detail_attributes)
      respond_to do |format|
        format.json{render :json => {taggable_type: "projects", taggable_id: @project.id}}
        format.html{redirect_to new_user_asset_path}
      end
    else
      flash.now[:danger] = @project.errors.full_messages
    end
  end

  def update
    @project = Project.find(params[:id])
    @project.descriptions.delete_all
    pass_params = project_params
    detail_attributes = pass_params.delete(:details) || []
    @project.update(pass_params)
    if @project.save
      addDescriptions(@project, detail_attributes)
    else
      flash.now[:danger] = @project.errors.full_messages
    end
    render partial: 'show', locals: {asset: @project, asset_type: "projects", asset_descriptions: @project.descriptions}
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    render nothing: true, status: 200, content_type: "text/html"
  end
  private

  def project_params
    params.require(:project).permit(:description, :title, :tags_string, :details =>[:detail], :descriptions_attributes => [:detail])
  end
end
