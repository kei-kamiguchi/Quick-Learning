class Subject < ApplicationRecord
  belongs_to :project
  belongs_to :category
  has_many :parts, dependent: :destroy

  validates :title, presence: true
end
