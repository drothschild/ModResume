class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :tags, through: :taggings
  has_many :taggings, as: :taggable
end
