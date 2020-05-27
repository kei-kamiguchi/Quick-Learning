class UserAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :test_question

  enum edit: { edit: 0, editing: 1 }
  validates :edit, presence: true
  validates :edit, inclusion: { in: UserAnswer.edits.keys }

  def toggle_status!
    if edit?
      editing!
    else
      edit!
    end
  end
end
