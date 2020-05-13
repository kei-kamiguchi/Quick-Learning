class UserParticipationsController < ApplicationController
  skip_before_action :admin_login_required

  def create
    user_participation = current_user.user_participations.create(project_id: params[:project_id])
    user_choice_category = current_user.user_choice_categories.create(category_id: user_project.categories.last.id)
    redirect_to current_user, notice: "プロジェクトへ参加しました！"
  end
end
