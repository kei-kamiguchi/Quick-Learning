class AddReplyToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :reply, :boolean, default: true
  end
end
