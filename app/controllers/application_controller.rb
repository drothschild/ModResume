class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def asset_types
    @asset_types = ["objectives", "experiences", "projects", "educations", "skills", "volunteerings"]
  end


  def set_assets
    @user = User.find(current_user.id)
    @asset_types.each do |asset_type|
      @assets["#{asset_type}"] = []
      resume_assets = ResumeAsset.where("resume_id=? AND buildable_type=?", params[:id], asset_type.capitalize.singularize)
      resume_assets.each do |resume_asset|
        @assets["#{asset_type}"] << resume_asset.buildable
      end
    end

  end


  def after_sign_in_path_for(resource)
    user_resumes_path(resource)
  end
end
