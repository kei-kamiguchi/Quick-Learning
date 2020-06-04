class AnswerPaper < ApplicationRecord
  belongs_to :user
  belongs_to :test_question, optional: true

  enum edit: { edit: 0, editing: 1 }
  enum checked: { unchecked: 0, checked: 1 }
  validates :edit, :checked, presence: true
  validates :edit, inclusion: { in: AnswerPaper.edits.keys }
  validates :checked, inclusion: { in: AnswerPaper.checkeds.keys }

  def toggle_edit!
    if edit?
      editing!
    else
      edit!
    end
  end

  def toggle_checked!
    if unchecked?
      checked!
    else
      unchecked!
    end
  end

end
