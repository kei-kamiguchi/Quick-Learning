class UsersController < ApplicationController
  skip_before_action :admin_login_required
  before_action :set_user, only: [:destroy, :show]

  def index
    @users = admin_project.user_participation_users
  end

  def show
    @user = User.find(params[:id])
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
