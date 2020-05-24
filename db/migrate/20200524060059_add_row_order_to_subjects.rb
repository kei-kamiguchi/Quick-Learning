class AddRowOrderToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :row_order, :integer
  end
end
