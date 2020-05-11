class ProjectUsersController < ApplicationController
  skip_before_action :admin_login_required

  def create
    project_user = current_user.project_users.create(project_id: params[:project_id])
    redirect_to current_user, notice: "プロジェクトへ参加しました！"
  end
end
