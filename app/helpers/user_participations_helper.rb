module UserParticipationsHelper
  def user_project
    current_user.user_participation_projects.last
  end

  def user_participation?
    current_user.user_participations.present?
  end

  def user_invitee_project
    Admin.find(current_user.invited_by_id).admin_participation_projects.last
  end
end
