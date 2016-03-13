class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :resumes, through: :taggings, source: :taggable, source_type: "Resume"
  has_many :experiences, through: :taggings, source: :taggable, source_type: "Experience"
  has_many :objectives, through: :taggings, source: :taggable, source_type: "Objective"
  has_many :skills, through: :taggings, source: :taggable, source_type: "Skill"
  has_many :volunteerings, through: :taggings, source: :taggable, source_type: "Volunteering"
  has_many :projects, through: :taggings, source: :taggable, source_type: "Project"
  has_many :educations, through: :taggings, source: :taggable, source_type: "Education"
end
