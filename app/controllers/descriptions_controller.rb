class DescriptionsController < ApplicationController
  def destroy
    @description = Descriptions.find(params[:id])
    @description.destroy
    render nothing: true, status: 200, content_type: "text/html"
  end
end
