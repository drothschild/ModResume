module Buildable
  extend ActiveSupport::Concern

  included do 
    has_many :resumes, through: :resume_assets
    has_many :resume_assets, as: :buildable, dependent: :destroy
  end
end