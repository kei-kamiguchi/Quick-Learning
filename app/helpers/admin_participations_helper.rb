module AdminParticipationsHelper
  def admin_project
    current_admin.admin_participation_projects.last
  end

  def admin_participation?
    current_admin.admin_participations.present?
  end

  def admin_invitee_project
    Admin.find(current_admin.invited_by_id).admin_participation_projects.last
  end
end
