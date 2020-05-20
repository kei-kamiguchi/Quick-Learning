class UsersController < ApplicationController
  skip_before_action :admin_login_required, only: [:show]
  before_action :set_user, only: [:destroy, :show]

  def index
    @users = admin_project.user_participation_users
  end

  def show
    # @subjects = Subject.eager_load(:parts).where(project_id: user_project.id).order(created_at: :desc)
    # @parts = Part.joins(subject: :project).where(projects: {id: user_project.id}).order(created_at: :desc)
  end

  def destroy
    @user.destroy
    flash[:notice] = "生徒を削除しました。"
    redirect_back(fallback_location: root_path)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
