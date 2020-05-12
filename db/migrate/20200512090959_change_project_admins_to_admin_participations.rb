class ChangeProjectAdminsToAdminParticipations < ActiveRecord::Migration[5.2]
  def change
    rename_table :project_admins, :admin_participations
  end
end
