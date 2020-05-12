# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  skip_before_action :login_required
  skip_before_action :admin_login_required
  skip_before_action :logout_required, only: [:create, :destroy]

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def new_guest
    admin = Admin.guest
    sign_in admin
    redirect_to project_subjects_path(admin_project), notice: 'ゲスト管理者としてログインしました。'
  end


  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
