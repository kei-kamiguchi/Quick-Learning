class AddTestIdToUserAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :user_answers, :test_id, :integer
  end
end
