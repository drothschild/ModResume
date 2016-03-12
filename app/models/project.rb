class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tags, through: :taggings
  has_many :taggings, as: :taggable
  has_many :resumes, through: :resume_assets
  has_many :resume_assets, as: :buildable
  has_many :descriptions, through: :describings
  has_many :describings, as: :describable
end
