class AddBackedToAnswerPapers < ActiveRecord::Migration[5.2]
  def change
    add_column :answer_papers, :backed, :boolean, null: false, default: false
  end
end
