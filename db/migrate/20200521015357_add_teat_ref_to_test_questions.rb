class AddTeatRefToTestQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :test_questions, :test, foreign_key: true
  end
end
