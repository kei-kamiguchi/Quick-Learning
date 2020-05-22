class CreateUserAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_answers do |t|
      t.integer :user_id
      t.integer :test_question_id
      t.text :answer

      t.timestamps
    end
  end
end
