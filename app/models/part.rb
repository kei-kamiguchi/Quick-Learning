class Part < ApplicationRecord
  belongs_to :subject
  has_many :questions, dependent: :destroy
  has_many :achieveds, dependent: :destroy
  has_many :achieved_users, through: :achieveds, source: :user

  validates :title, :content, presence: true
end
