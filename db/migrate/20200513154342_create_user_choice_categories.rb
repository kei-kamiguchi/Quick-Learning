class CreateUserChoiceCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_choice_categories do |t|
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end
end
