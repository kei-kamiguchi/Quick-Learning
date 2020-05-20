class RemoveStatusFromParts < ActiveRecord::Migration[5.2]
  def change
    remove_column :parts, :status, :integer
  end
end
