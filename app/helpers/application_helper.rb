module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def is_tagged?(asset, tag)
    @taggings = Tagging.where("tag_id = ? AND taggable_id=?", tag.id, asset.id)
    if @taggings.length > 0
      true
    else
      false
    end
  end

  def get_tagging_id(asset, tag)
      @taggings = Tagging.where("tag_id = ? AND taggable_id=?", tag.id, asset.id)
      return @taggings.first.id
  end

end
