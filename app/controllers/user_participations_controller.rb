class UserParticipationsController < ApplicationController
  skip_before_action :admin_login_required
  skip_before_action :category_choice_required

  def new
  end

  def create
    user_participation = current_user.user_participations.create(project_id: params[:project_id])
    redirect_to current_user, notice: "プロジェクトへ参加しました！"
  end
end
