class AnswerPaper < ApplicationRecord
  belongs_to :user
  belongs_to :test_question, optional: true

  enum edit: { edit: 0, editing: 1 }
  enum checked: { checked: 0, unchecked: 1 }
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
    if checked?
      unchecked!
    else
      checked!
    end
  end

end
