class Education < ActiveRecord::Base
  include Taggable
  include Buildable
  include Describable
  belongs_to :user

  validates :institution_name, presence: true
  validates :user_id, presence: true

end
