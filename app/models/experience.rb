class Experience < ActiveRecord::Base
  include Taggable
  include Buildable
  include Describable
  belongs_to :user

  validates :company, presence: true
  validates :title, presence: true
  validates :user_id, presence: true
end
