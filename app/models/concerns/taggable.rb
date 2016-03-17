module Taggable
  extend ActiveSupport::Concern

  included do 
    has_many :tags, through: :taggings
    has_many :taggings, as: :taggable
  end
end
