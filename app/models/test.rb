class Test < ApplicationRecord
  belongs_to :project
  belongs_to :subject
  validates :title, presence: true
end
