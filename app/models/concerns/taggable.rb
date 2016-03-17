module Taggable
  extend ActiveSupport::Concern

  included do 
    has_many :tags, through: :taggings
    has_many :taggings, as: :taggable
  end

  

  def tags_string=(tags_string)
    tag_names = tags_string.split(',')
    tag_names.each do |word|
      word = word.strip
      tag =Tag.find_or_create_by(name: word, user: current_user)
      tags << tag
    end
  end
end
