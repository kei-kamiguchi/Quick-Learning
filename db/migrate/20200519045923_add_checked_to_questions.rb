class AddCheckedToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :checked, :boolean, default: false
  end
end
