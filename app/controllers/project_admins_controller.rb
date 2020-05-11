class ProjectAdminsController < ApplicationController
  skip_before_action :admin_login_required
  #ここでactiveにするプロジェクトを切り替えている
  #参加中にできるプロジェクトは1つだけなので、createが走るたびに元のプロジェクトからの退出も行われる
  #以下はすでにプロジェクトに参加済みの者、プロジェクトに招待された者、新規でプロジェクトを作成する者で分岐している
  def create
    if admin_participation?
      project_admin = current_admin.project_admins.last.destroy
      project_admin = current_admin.project_admins.create(project_id: params[:project_id])
      flash[:notice] = "プロジェクトを変更しました！"
      redirect_back(fallback_location: root_path)
    elsif current_admin.invited_by_id.present?
      project_admin = current_admin.project_admins.create(project_id: params[:project_id])
      redirect_to project_subjects_path(admin_project), notice: "プロジェクトに参加しました！"
    else
      project_admin = current_admin.project_admins.create(project_id: params[:project_id])
      redirect_to project_subjects_path(admin_project), notice: "プロジェクトが正常に作成されました！"
    end
  end
end
