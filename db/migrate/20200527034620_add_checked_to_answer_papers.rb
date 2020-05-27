class AddCheckedToAnswerPapers < ActiveRecord::Migration[5.2]
  def change
    add_column :answer_papers, :checked, :integer, null: false, default: 0
  end
end
