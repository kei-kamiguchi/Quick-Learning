class Subject < ApplicationRecord
  include RankedModel
  ranks :row_order, :with_same => :project_id

  belongs_to :project
  belongs_to :category
  has_many :parts, dependent: :destroy
  has_many :tests, dependent: :destroy

  validates :title, presence: true
end
