class AddRowOrderToTestQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :test_questions, :row_order, :integer
  end
end
