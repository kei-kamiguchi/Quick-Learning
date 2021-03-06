class ProjectsController < ApplicationController
  skip_before_action :category_choice_required, only: [:new, :create]
  before_action :set_project, only: [:update, :destroy]

  def index
    @projects = current_admin.projects.order(created_at: :desc)
    @project = Project.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_admin.projects.build(project_params)
    if @project.save
      Category.create(title: "未分類", project_id: @project.id)
      if current_admin.projects.size() > 1
        redirect_back(fallback_location: root_path)
      else
        redirect_to new_admin_participation_path, notice: "プロジェクトを作成しました！カリキュラムの作成に取り掛かりましょう！"
      end
    else
      flash[:alert] = "プロジェクトを作成できませんでした。"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: "プロジェクト名を更新しました！"
    else
      flash[:alert] = "プロジェクト名を更新できませんでした。"
      redirect_back(fallback_location: root_path)
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

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
