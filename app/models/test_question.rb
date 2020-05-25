class TestQuestion < ApplicationRecord
  include RankedModel
  ranks :row_order

  belongs_to :test
  has_many :user_answers, dependent: :destroy
  has_many :user_answer_users, through: :user_answers, source: :user
  validates :content, :form_size, presence: true
end
