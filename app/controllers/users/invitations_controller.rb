class Users::InvitationsController < Devise::InvitationsController
  skip_before_action :login_required
  skip_before_action :admin_login_required
  skip_before_action :logout_required
  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end
end
