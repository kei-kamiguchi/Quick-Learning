class UserAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :test_question
end
