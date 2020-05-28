class UserParticipationsController < ApplicationController
  skip_before_action :admin_login_required
  skip_before_action :category_choice_required

  def new
    if user_participation?
      redirect_to current_user
    else
      @user_participation = current_user.user_participations.find_by(project_id: user_invitee_project.id)
    end
  end

  def create
    user_participation = current_user.user_participations.create(project_id: params[:project_id])
    redirect_to current_user, notice: "プロジェクトへ参加しました！"
  end
end
