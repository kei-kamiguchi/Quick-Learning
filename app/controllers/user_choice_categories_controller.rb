class UserChoiceCategoriesController < ApplicationController
  skip_before_action :admin_login_required
  skip_before_action :category_choice_required

  def create
    if user_choosed_category?
      user_choice_category = UserChoiceCategory.where(user_id: current_user.id).destroy_all
      user_choice_category = current_user.user_choice_categories.create(category_id: params[:category_id])
      flash[:notice] = "カテゴリを変更しました！"
      redirect_back(fallback_location: root_path)
    else
      user_choice_category = current_user.user_choice_categories.create(category_id: params[:category_id])
      redirect_to current_user, notice: "プロジェクトが正常に作成されました！"
    end
  end
end
