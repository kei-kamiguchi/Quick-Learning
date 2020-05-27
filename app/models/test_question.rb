class TestQuestion < ApplicationRecord
  include RankedModel
  ranks :row_order

  belongs_to :test
  has_many :answer_papers, dependent: :destroy
  has_many :answer_paper_users, through: :answer_papers, source: :user
  validates :content, :form_size, presence: true
end
