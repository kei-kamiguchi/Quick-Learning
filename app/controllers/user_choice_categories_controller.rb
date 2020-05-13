class UserChoiceCategoriesController < ApplicationController
  skip_before_action :admin_login_required

  def create
    if user_choice_category?
      user_choice_category = current_user.user_choice_categories.last.destroy
      user_choice_category = current_user.user_choice_categories.create(category_id: params[:category_id])
      flash[:notice] = "カテゴリを変更しました！"
      redirect_back(fallback_location: root_path)
    else
      user_choice_category = current_user.user_choice_categories.create(category_id: params[:category_id])
      redirect_to project_subjects_path(user_project), notice: "プロジェクトが正常に作成されました！"
    end
  end
end
