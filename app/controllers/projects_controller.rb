class ProjectsController < ApplicationController
  skip_before_action :admin_login_required, only: [:introduction]
  before_action :set_project, only: [:edit, :update, :destroy, :show, :project_launch]

  def index
    @projects = current_admin.projects.order(created_at: :desc)
    @project = Project.new
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def show
    @subjects = @project.subjects
  end

  # プロジェクトを作成したことがあるかないかで分岐
  def create
    @project = current_admin.projects.build(project_params)
    if @project.save
      if current_admin.projects.count() > 1
        redirect_back(fallback_location: root_path)
      else
        redirect_to project_launch_project_path(@project), notice: "プロジェクトを作成しました！カリキュラムの作成に取り掛かりましょう！"
      end
    else
      flash[:alert] = "プロジェクトを作成できませんでした。"
      redirect_back(fallback_location: root_path)
    end
  end

  def project_launch
    @project_admin = current_admin.project_admins.find_by(project_id: @project.id)
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: "プロジェクト名を更新しました！"
    else
      render 'edit'
    end
  end

  def destroy
    unless @project == admin_project
      @project.destroy
      redirect_to projects_path, notice: 'プロジェクトを削除しました！'
    else
      redirect_to projects_path, alert: "active中のプロジェクトは削除できません！！"
    end
  end

  # 生徒を招待、社員が社員を招待、アプリ管理者がクライアントを招待、クライアントがプロジェクトを作成した際、それ以外の場合分け
  # current_admin.invited_by_id.present?はアプリ管理者がクライアントを招待する際に設定していないとエラーになる
  def introduction
    if current_user.present?
      if user_project.nil?
        @project_user = current_user.project_users.find_by(project_id: Admin.find(current_user.invited_by_id).project_admin_projects.last.id)
        return
      else
        redirect_to current_user
      end
    elsif current_admin.nil?
      redirect_to new_admin_session_path
    elsif current_admin.invited_by_id.nil?
      redirect_to projects_path
    elsif current_admin.project_admin_projects.present?
      @project_admin = current_admin.project_admin_projects.last
    elsif Admin.find(current_admin.invited_by_id).project_admin_projects.present?
      @project_admin = current_admin.project_admins.find_by(project_id: Admin.find(current_admin.invited_by_id).project_admin_projects.last.id)
    elsif Admin.find(current_admin.invited_by_id).project_admin_projects.empty?
      redirect_to new_project_path
    else
      redirect_to new_user_session_path
    end
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
