class AddCorrectAnswerToTestQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :test_questions, :correct_answer, :text, null: false
  end
end
