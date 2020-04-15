class User < ApplicationRecord
  has_many :project_users, dependent: :destroy
  has_many :project_user_projects, through: :project_users, source: :project
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, invite_for: 24.hours
  validates :name, presence: true
end
