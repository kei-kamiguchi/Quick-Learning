class AdminParticipationsController < ApplicationController
  skip_before_action :category_choice_required
  #プロジェクトへ参加済みのadmin、未参加のadmin、参加済みのuser、未参加のuserで条件分岐
  def new
    if admin_participation?
      redirect_to project_subjects_path(admin_project)
    else
      @admin_participation = current_admin.admin_participations.find_by(project_id: admin_invitee_project.id)
    end
  end
  #ここでactiveにするプロジェクトを切り替えている
  def create
    if admin_participation?
      admin_participation = AdminParticipation.where(admin_id: current_admin.id).destroy_all
      admin_participation = current_admin.admin_participations.create(project_id: params[:project_id])
      flash[:notice] = "プロジェクトを変更しました！"
      redirect_back(fallback_location: root_path)
    elsif current_admin.invited_by_id.present?
      admin_participation = current_admin.admin_participations.create(project_id: params[:project_id])
      redirect_to project_subjects_path(admin_project), notice: "プロジェクトに参加しました！"
    else
      admin_participation = current_admin.admin_participations.create(project_id: params[:project_id])
      current_admin.update(admin: 1)
      redirect_to project_subjects_path(admin_project), notice: "プロジェクトが正常に作成されました！"
    end
  end
end
