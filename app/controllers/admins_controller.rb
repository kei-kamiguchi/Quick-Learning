class AdminsController < ApplicationController
  before_action :set_admin, only: [:destroy, :show, :toggle_admin]

  def index
    @admins = admin_project.admin_participation_admins
  end

  def show
  end

  def destroy
    @admin.destroy
    flash[:notice] = "社員を削除しました。"
    redirect_back(fallback_location: root_path)
  end

  def toggle_admin
    @admin.toggle_admin!
    redirect_back(fallback_location: root_path)
  end

  private

  def set_admin
    @admin = Admin.find(params[:id] || params[:admin_id])
  end    
end
