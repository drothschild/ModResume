class Resume < ActiveRecord::Base
  include Taggable
  belongs_to :user
  has_many :resume_assets, dependent: :destroy
  has_many :experiences, through: :resume_assets, source: :buildable, source_type: "Experience"
  has_many :objectives, through: :resume_assets, source: :buildable, source_type: "Objective"
  has_many :skills, through: :resume_assets, source: :buildable, source_type: "Skill"
  has_many :volunteerings, through: :resume_assets, source: :buildable, source_type: "Volunteering"
  has_many :projects, through: :resume_assets, source: :buildable, source_type: "Project"
  has_many :educations, through: :resume_assets, source: :buildable, source_type: "Education"

  validates :target_job, presence: true
end
