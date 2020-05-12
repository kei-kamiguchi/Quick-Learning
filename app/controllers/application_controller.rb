class ApplicationController < ActionController::Base
  include AdminParticipationsHelper
  include UserParticipationsHelper
  # CSRF対策
  protect_from_forgery with: :exception
  # ログイン済の場合のみアクセスを許可
  before_action :login_required
  #ログアウト済の場合のみアクセスを許可
  before_action :logout_required, if: :devise_controller?
  # adminユーザーのみアクセスを許可
  before_action :admin_login_required
  # ログイン後の遷移先を分岐
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      if admin_participation?
        project_subjects_path(admin_project)
      elsif current_admin.invited_by_id.present?
        introduction_projects_path
      else
        new_project_path
      end
    when User
      unless user_participation?
        introduction_projects_path
      else
        current_user
      end
    end
  end

  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def login_required
    redirect_to new_user_session_path unless current_user || current_admin
  end

  def logout_required
    redirect_back(fallback_location: root_path) if admin_signed_in? || user_signed_in?
  end

  def admin_login_required
    redirect_back(fallback_location: root_path) unless current_admin
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:invite, keys: [:name])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end
# adminモデルであればどのモデルに対しても招待可能（デフォルトでは同一モデルしか招待できない）
  def authenticate_inviter!
    authenticate_admin!(force: true)
  end
end
