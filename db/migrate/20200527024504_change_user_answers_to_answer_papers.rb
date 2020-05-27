class ChangeUserAnswersToAnswerPapers < ActiveRecord::Migration[5.2]
  def change
    rename_table :user_answers, :answer_papers
  end
end
