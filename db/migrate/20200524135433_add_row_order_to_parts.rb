class AddRowOrderToParts < ActiveRecord::Migration[5.2]
  def change
    add_column :parts, :row_order, :integer
  end
end
