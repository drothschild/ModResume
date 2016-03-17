class Skill < ActiveRecord::Base
  include Taggable
  include Buildable
  include Describable
  belongs_to :user
end
