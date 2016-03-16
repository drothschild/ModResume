class VisitorsController < ApplicationController
  def index
  end

  def contact
    h = JSON.generate({ 'name' => params[:name],
                        'email' => params[:email],
                        'message' => params[:message] })

    PostmanWorker.perform_async(h, 5)


    redirect_to :root
  end

end
