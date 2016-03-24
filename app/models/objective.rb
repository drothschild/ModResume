class Objective < ActiveRecord::Base
  include Taggable
  include Buildable
  include Describable
  belongs_to :user

  validates :description, presence: true
  validates :user_id, presence: true
end
