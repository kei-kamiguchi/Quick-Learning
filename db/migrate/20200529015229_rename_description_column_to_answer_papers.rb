class RenameDescriptionColumnToAnswerPapers < ActiveRecord::Migration[5.2]
  def change
    rename_column :answer_papers, :description, :advice
  end
end
