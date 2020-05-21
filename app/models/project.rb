class Project < ApplicationRecord
  belongs_to :admin
  has_many :subjects, dependent: :destroy
  has_many :user_participations, dependent: :destroy
  has_many :user_participation_users, through: :user_participations, source: :user
  has_many :admin_participations, dependent: :destroy
  has_many :admin_participation_admins, through: :admin_participations, source: :admin
  has_many :categories, dependent: :destroy
  has_many :tests, dependent: :destroy

  validates :title, presence: true
end
