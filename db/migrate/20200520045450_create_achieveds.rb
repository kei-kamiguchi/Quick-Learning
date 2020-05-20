class CreateAchieveds < ActiveRecord::Migration[5.2]
  def change
    create_table :achieveds do |t|
      t.integer :user_id
      t.integer :part_id

      t.timestamps
    end
  end
end
