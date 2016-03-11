class ResumeAsset < ActiveRecord::Base
  belongs_to :resume
  belongs_to :buildable, polymorphic: true
end
