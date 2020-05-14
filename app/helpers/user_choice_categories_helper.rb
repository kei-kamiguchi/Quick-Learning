module UserChoiceCategoriesHelper
  def user_choosed_category
    current_user.user_choice_category_categories.last
  end

  def user_choosed_category?
    current_user.user_choice_categories.present?
  end
end
