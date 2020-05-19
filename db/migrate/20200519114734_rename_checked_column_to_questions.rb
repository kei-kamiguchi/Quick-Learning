class RenameCheckedColumnToQuestions < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :checked, :checked_by_admin
  end
end
