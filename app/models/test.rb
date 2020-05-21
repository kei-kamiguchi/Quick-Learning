class Test < ApplicationRecord
  belongs_to :project
  belongs_to :subject
  has_many :test_questions, dependent: :destroy
  validates :title, presence: true
end
