class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable
  has_many :websites
  has_many :tags
  has_many :resumes
  has_many :objectives
  has_many :skills
  has_many :volunteerings
  has_many :experiences
  has_many :projects
  has_many :educations

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :email, { presence: true, uniqueness: true }
end
