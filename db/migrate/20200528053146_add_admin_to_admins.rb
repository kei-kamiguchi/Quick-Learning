class AddAdminToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :admin, :integer, null: false, default: 0
  end
end
