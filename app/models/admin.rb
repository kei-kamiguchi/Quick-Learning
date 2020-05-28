class Admin < ApplicationRecord
  include DeviseInvitable::Inviter

  has_many :projects, dependent: :destroy
  has_many :admin_participations, dependent: :destroy
  has_many :admin_participation_projects, through: :admin_participations, source: :project, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :admin_choice_categories, dependent: :destroy
  has_many :admin_choice_category_categories, through: :admin_choice_categories, source: :category

  devise :invitable, :database_authenticatable, :validatable, :registerable, :recoverable, :rememberable, :validatable, invite_for: 24.hours
  validates :name, :admin, :email, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  def self.guest
    find_or_create_by!(email: 'admin0@example.com') do |admin|
      admin.name = "ゲスト管理者"
      admin.password = "password"
    end
  end

  enum admin: { false: 0, true: 1 }
  validates :admin, inclusion: { in: Admin.admins.keys }

  def toggle_admin!
    if false?
      true!
    else
      false!
    end
  end
end
