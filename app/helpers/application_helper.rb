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

  def all_tags
    @tags = Tag.where("user_id = ?", current_user.id)
  end

  def all_tag_names
    @tag_names = []
    @tags = all_tags
    @tags.each do |tag|
      @tag_names << tag.name
    end
    return @tag_names
  end

  def get_asset_tag_ids(asset)
    asset_tags = []
    asset.tags.each do |tag|
      asset_tags << "|#{tag.id}|"
    end

    return asset_tags
  end

  def get_tagging_id(asset, tag)
      @taggings = Tagging.where("tag_id = ? AND taggable_id=?", tag.id, asset.id)
      return @taggings.first.id
  end

  def current_url
    return request.fullpath
  end

  def asset_types
    @asset_types = ["objectives", "experiences", "projects", "educations", "skills", "volunteerings"]
  end

  def asset_type_grammar(asset_type)
    grammar_hash =  { "objectives" =>"Objective",
                      "experiences" =>"Experience",
                      "projects"=>"Projects",
                      "educations"=>"Education",
                      "skills"=>"Skills",
                      "volunteerings"=>"Volunteer"
                    }
    grammar_hash[asset_type]
  end
end
