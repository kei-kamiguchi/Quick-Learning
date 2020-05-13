class Category < ApplicationRecord
  validates :title, presence: true
  has_many :subjects
  belongs_to :project
end
