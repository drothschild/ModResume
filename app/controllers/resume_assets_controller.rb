class ResumeAssetsController < ApplicationController

  def create
    @resume_asset = ResumeAsset.new(resume_asset_params)
    p "*" * 50
    p @resume_asset
    p "params..."
    p params
    p "*" * 50

    respond_to do |format|
      format.html{}
      format.json{render json: @resume_asset}
    end
  end


  def update
    resumeAsset = ResumeAsset.where(buildable_type: params[:asset_type], buildable_id: params[:id], resume_id:params[:resume_id])
    p params
    resumeAsset.each do |current_resume|
      current_resume.assign_attributes(div_sort: params[:div_sort])
      current_resume.save
    end
    render json: resumeAsset
  end

private

  def resume_asset_params
    params.require(:resume_asset).permit(:id, :resume_id, :buildable_id, :buildable_type)
  end

  def find_builder
  end

end
