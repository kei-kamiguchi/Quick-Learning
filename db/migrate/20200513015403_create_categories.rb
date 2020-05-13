class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title, null: false, default: '未分類'

      t.timestamps
    end
  end
end
