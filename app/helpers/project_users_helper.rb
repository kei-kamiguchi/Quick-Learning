module ProjectUsersHelper
  def user_project
    current_user.project_user_projects.last
  end

  def user_participation?
    current_user.project_users.present?
  end
end
