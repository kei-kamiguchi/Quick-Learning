class AchievedsController < ApplicationController
  skip_before_action :admin_login_required

  def create
    achieved = current_user.achieveds.create(part_id: params[:part_id])
    redirect_back(fallback_location: root_path)
  end
  def destroy
    achieved = current_user.achieveds.find_by(id: params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end
end
