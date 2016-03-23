class ResumeAsset < ActiveRecord::Base
  belongs_to :resume
  belongs_to :buildable, polymorphic: true
  has_many :descriptions, through: :describings
  has_many :describings, as: :describable, dependent: :destroy

  validates :resume_id, presence: true
  validates :buildable_type, presence: true
  validates :buildable_id, presence: true

end
