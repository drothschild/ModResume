class ResumeAssetsController < ApplicationController

  def create
    @resume_asset = ResumeAsset.new(resume_asset_params)
    respond_to do |format|
      format.html{}
      format.json{render json: @resume_asset}
    end
  end


  def update
    p params
  end


private

  def resume_asset_params
    params.require(:resume_asset).permit(:id, :resume_id, :buildable_id, :buildable_type)
  end

  def find_builder
  end

end
