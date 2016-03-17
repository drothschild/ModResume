module Taggable
  extend ActiveSupport::Concern

  included do 
    has_many :tags, through: :taggings
    has_many :taggings, as: :taggable
  end


  def tags_string 
    tags.order("name").map{|t| t.name}.join(", ")
  end

  def tags_string=(tags_string)
    self.tags.destroy_all
    tag_names = tags_string.split(',')
    tag_names.each do |word|
      word = word.strip
      tag = Tag.find_or_create_by(name: word, user: user)
      self.tags << tag
      tag.save
    end
  end
end
