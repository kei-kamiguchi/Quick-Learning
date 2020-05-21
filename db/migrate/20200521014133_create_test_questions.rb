class CreateTestQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :test_questions do |t|
      t.string :title
      t.text :content, null: false
      t.integer :form, null: false, default: 1
      t.integer :form_size, null: false, default: 1

      t.timestamps
    end
  end
end
