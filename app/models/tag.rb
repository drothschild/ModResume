class Tag < ActiveRecord::Base
  # belongs_to :user
  has_many :taggings
  has_many :resumes, through: :taggings, source: :taggable, source_type: "Resume"
end
