class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :tags, through: :taggings
  has_many :taggings, as: :taggable
  has_many :resume_assets
  has_many :experiences, through: :resume_assets, source: :buildable, source_type: "Experience"
  has_many :objectives, through: :resume_assets, source: :buildable, source_type: "Objective"
  has_many :skills, through: :resume_assets, source: :buildable, source_type: "Skill"
  has_many :volunteerings, through: :resume_assets, source: :buildable, source_type: "Volunteering"
  has_many :projects, through: :resume_assets, source: :buildable, source_type: "Project"
  has_many :educations, through: :resume_assets, source: :buildable, source_type: "Education"
end
