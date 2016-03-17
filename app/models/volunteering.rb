class Volunteering < ActiveRecord::Base
  include Taggable
  include Buildable
  include Describable
  belongs_to :user

  validates :organization, presence: true
  validates :user_id, presence: true

end
