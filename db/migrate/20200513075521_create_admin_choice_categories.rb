class CreateAdminChoiceCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_choice_categories do |t|
      t.integer :admin_id
      t.integer :category_id

      t.timestamps
    end
  end
end
