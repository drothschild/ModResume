class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :require_login

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
  def parse_tags_names(words)
    word_list = words.split(',')
    tags = []
    word_list.each do |word|
      word = word.strip
      tag =Tag.find_or_create_by(name: word, user: current_user)
      tags << tag
    end
    tags
  end

  def after_sign_in_path_for(resource)
    user_resumes_path(resource)
  end

  def require_login

    

  end

  protected



  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :phone_number) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :phone_number) }
  end

  private

  def require_login
    if current_user == nil
      flash[:error] = "You must be logged in to access this section"
      redirect_to :new_user_session
    elsif params[:user_id] != nil && params[:user_id].to_i != current_user.id
      flash.now[:danger] = "You must be logged in to access this section"
      redirect_to :root
    end

  end


end
