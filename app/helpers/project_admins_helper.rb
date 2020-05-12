module ProjectAdminsHelper
  def admin_project
    current_admin.project_admin_projects.last
  end

  def admin_participation?
    current_admin.project_admins.present?
  end

  def admin_invitee_project
    Admin.find(current_admin.invited_by_id).project_admin_projects.last
  end
end
