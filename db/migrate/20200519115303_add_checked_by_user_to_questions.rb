class AddCheckedByUserToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :checked_by_user, :boolean, default: true
  end
end
