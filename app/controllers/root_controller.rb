class RootController < ApplicationController
  skip_before_action :require_login
  def index
  end

  def about
  end
end
