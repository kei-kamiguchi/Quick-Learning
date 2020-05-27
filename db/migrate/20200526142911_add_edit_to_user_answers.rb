class AddEditToUserAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :user_answers, :edit, :integer, null: false, default: 0
  end
end
