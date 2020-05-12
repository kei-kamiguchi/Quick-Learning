class UserParticipationsController < ApplicationController
  skip_before_action :admin_login_required

  def create
    user_participation = current_user.user_participations.create(project_id: params[:project_id])
    redirect_to current_user, notice: "プロジェクトへ参加しました！"
  end
end
