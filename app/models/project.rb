class Project < ApplicationRecord
  belongs_to :admin
  has_many :subjects, dependent: :destroy
  has_many :project_users, dependent: :destroy
  has_many :project_user_users, through: :project_users, source: :user
  has_many :project_admins, dependent: :destroy
  has_many :project_admin_admins, through: :project_admins, source: :admin

  validates :title, presence: true
end
