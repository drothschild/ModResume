class Project < ActiveRecord::Base
  belongs_to :user
  include Taggable
  include Buildable
  include Describable
end
