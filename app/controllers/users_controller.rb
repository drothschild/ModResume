require 'pdf-reader'

class UsersController < ApplicationController
  include PdfHelper
  skip_before_action :require_login
  def show
    @user = User.find(current_user.id)
    @new_website = Website.new(user_id: current_user.id)
  end

  def pdf
  end

  def pdf_parse
    uploaded_file = params[:linked_in]
    reader = PDF::Reader.new(params[:linked_in].tempfile.path)
    PdfHelper.parse_pdf(reader, current_user)
    redirect_to user_assets_url(current_user)
  end

end
