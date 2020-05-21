class TestQuestion < ApplicationRecord
  belongs_to :test
  validates :content, :form_size, presence: true
end
