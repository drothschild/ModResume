class Describing < ActiveRecord::Base
  belongs_to :description
  belongs_to :describable, polymorphic: true
end