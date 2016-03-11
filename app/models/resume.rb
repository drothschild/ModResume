class Resume < ActiveRecord::Base
  has_many :tags, through: :taggings
  has_many :taggings, as: :taggable
end
