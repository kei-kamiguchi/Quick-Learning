class AddProjectRefToTests < ActiveRecord::Migration[5.2]
  def change
    add_reference :tests, :project, foreign_key: true
  end
end
