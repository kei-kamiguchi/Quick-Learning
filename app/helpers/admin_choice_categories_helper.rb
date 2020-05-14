module AdminChoiceCategoriesHelper
  def admin_choosed_category
    current_admin.admin_choice_category_categories.last
  end

  def admin_choosed_category?
    current_admin.admin_choice_categories.present?
  end
end
