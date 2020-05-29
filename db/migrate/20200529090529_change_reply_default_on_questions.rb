class ChangeReplyDefaultOnQuestions < ActiveRecord::Migration[5.2]
  def change
    change_column_default :questions, :reply, from: true, to: false
  end
end
