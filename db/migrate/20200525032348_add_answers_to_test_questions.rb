class AddAnswersToTestQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :test_questions, :answer, :text
  end
end
