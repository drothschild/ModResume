class Description < ActiveRecord::Base
  belongs_to :user
  has_many :describings, dependent: :destroy
  has_many :experiences, through: :describings, source: :describable, source_type: "Experience"
  has_many :resumes, through: :describings, source: :describable, source_type: "Resume"
  has_many :experiences, through: :describings, source: :describable, source_type: "Experience"
  has_many :objectives, through: :describings, source: :describable, source_type: "Objective"
  has_many :skills, through: :describings, source: :describable, source_type: "Skill"
  has_many :volunteerings, through: :describings, source: :describable, source_type: "Volunteering"
  has_many :projects, through: :describings, source: :describable, source_type: "Project"
  has_many :educations, through: :describings, source: :describable, source_type: "Education"
  # has_many :educations, through: :describings, source: :describable, source_type: "Education"
end