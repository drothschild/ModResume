class Website < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :user_id, presence: true
  validates :url, { presence: true, uniqueness: { scope: :user_id } }
end
