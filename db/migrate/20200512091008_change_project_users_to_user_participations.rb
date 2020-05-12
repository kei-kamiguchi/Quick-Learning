class ChangeProjectUsersToUserParticipations < ActiveRecord::Migration[5.2]
  def change
    rename_table :project_users, :user_participations
  end
end
