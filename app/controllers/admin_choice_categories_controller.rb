class AdminChoiceCategoriesController < ApplicationController
  def create
    if admin_choice_category?
      admin_choice_category = current_admin.admin_choice_categories.last.destroy
      admin_choice_category = current_admin.admin_choice_categories.create(category_id: params[:category_id])
      flash[:notice] = "カテゴリを変更しました！"
      redirect_back(fallback_location: root_path)
    else
      admin_choice_category = current_admin.admin_choice_categories.create(category_id: params[:category_id])
      redirect_to project_subjects_path(admin_project), notice: "プロジェクトが正常に作成されました！"
    end
  end
end
