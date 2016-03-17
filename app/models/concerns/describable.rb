module Describable
  extend ActiveSupport::Concern

  included do 
    has_many :descriptions, through: :describings, dependent: :destroy
    has_many :describings, as: :describable
    accepts_nested_attributes_for :descriptions, :allow_destroy => true
  end
end