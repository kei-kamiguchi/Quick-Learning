class AddTestTitleToUserAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :user_answers, :test_title, :string
  end
end
