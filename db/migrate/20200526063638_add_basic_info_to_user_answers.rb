class AddBasicInfoToUserAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :user_answers, :title, :string
    add_column :user_answers, :content, :text, null: false
    add_column :user_answers, :description, :text
    add_column :user_answers, :memo, :text
    add_column :user_answers, :correct_answer, :text, null: false
  end
end
