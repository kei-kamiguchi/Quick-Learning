class TestingsController < ApplicationController
  skip_before_action :admin_login_required

  def create
    testing = current_user.testings.create(test_id: params[:test_id])
    redirect_to entry_test_path(params[:test_id])
  end
  def destroy
    testing = current_user.testings.all.destroy
  end
end
