class AddCheckerToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :checker, :string
  end
end
