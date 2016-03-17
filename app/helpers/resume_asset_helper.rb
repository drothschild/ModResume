module ResumeAssetHelper
  def check_description(resume_id, asset_id, description_id)
    resume = Resume.find(resume_id)
    asset = resume.resume_assets.find_by(buildable_id: asset_id)
    description = Description.find(description_id)
    description == nil
    return true if asset == nil
    return true if asset.descriptions == nil
    asset.descriptions.include? description
  end
end