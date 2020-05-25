class AddRowOrderToTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :row_order, :integer
  end
end
