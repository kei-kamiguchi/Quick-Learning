class CreateTestings < ActiveRecord::Migration[5.2]
  def change
    create_table :testings do |t|
      t.integer :test_id
      t.integer :user_id

      t.timestamps
    end
  end
end
