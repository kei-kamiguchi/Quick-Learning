class RemoveFormFromTestQuestions < ActiveRecord::Migration[5.2]
  def change
    remove_column :test_questions, :form, :integer
  end
end
