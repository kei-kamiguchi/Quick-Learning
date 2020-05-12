module ProjectUsersHelper
  def user_project
    current_user.project_user_projects.last
  end

  def user_participation?
    current_user.project_users.present?
  end

  def user_invitee_project
    Admin.find(current_user.invited_by_id).project_admin_projects.last
  end
end
