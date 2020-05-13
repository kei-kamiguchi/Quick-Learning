class AddProjectRefToCategories < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories, :project, foreign_key: true
  end
end
