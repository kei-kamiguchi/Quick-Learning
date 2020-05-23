class AddActiveToTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :active, :integer, default: 0
  end
end
