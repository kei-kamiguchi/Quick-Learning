class User < ApplicationRecord
  has_many :user_participations, dependent: :destroy
  has_many :user_participation_projects, through: :user_participations, source: :project, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_choice_categories, dependent: :destroy
  has_many :user_choice_category_categories, through: :user_choice_categories, source: :category
  has_many :achieveds, dependent: :destroy
  has_many :achieved_parts, through: :achieveds, source: :part

  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, invite_for: 24.hours
  validates :name, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  def self.guest
    find_or_create_by!(email: 'user0@example.com') do |admin|
      user.name = "ゲストユーザー"
      user.password = "password"
    end
  end
end
