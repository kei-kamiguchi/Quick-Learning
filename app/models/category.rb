class Category < ApplicationRecord
  has_many :subjects
  belongs_to :project
  has_many :admin_choice_categories, dependent: :destroy
  has_many :admin_choice_category_admins, through: :admin_choice_categories, source: :admin
  has_many :user_choice_categories, dependent: :destroy
  has_many :user_choice_category_users, through: :user_choice_categories, source: :admin

  validates :title, presence: true
end
