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

  # プロジェクトを作成したことがあるかないかで分岐
  def create
    @project = current_admin.projects.build(project_params)
    if @project.save
      Category.create(title: "未分類", project_id: @project.id)
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
    @admin_participation = current_admin.admin_participations.find_by(project_id: @project.id)
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

  #プロジェクトへ参加済みのadmin、未参加のadmin、参加済みのuser、未参加のuserで条件分岐
  def introduction
    if admin_signed_in?
      if admin_participation?
        redirect_to project_subjects_path(admin_project)
      else
        @admin_participation = current_admin.admin_participations.find_by(project_id: admin_invitee_project.id)
      end
    else
      if user_participation?
        redirect_to current_user
      else
        @user_participation = current_user.user_participations.find_by(project_id: user_invitee_project.id)
      end
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
