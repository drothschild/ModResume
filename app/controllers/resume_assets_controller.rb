class ResumeAssetsController < ApplicationController

  def create
    @resume_asset = ResumeAsset.new(resume_asset_params)
    respond_to do |format|
      format.html{}
      format.json{render json: @resume_asset}
    end
  end


  def update
    p '*'*100
    curent_resume = ResumeAsset.find_by(buildable_type: params[:asset_type], buildable_id: params[:id])
    p params
    curent_resume.assign_attributes(div_sort: params[:div_sort])
    curent_resume.save
    p '*'*100
  end


private

  def resume_asset_params
    params.require(:resume_asset).permit(:id, :resume_id, :buildable_id, :buildable_type)
  end

  def find_builder
  end

end
