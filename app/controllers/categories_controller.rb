class CategoriesController < ApplicationController
  skip_before_action :admin_login_required
  skip_before_action :category_choice_required
  before_action :set_category, only: [:destroy, :update]

  def index
    @category = Category.new
    @project = admin_project
    @categories = Category.includes(subjects: :parts).where(project_id: @project.id)
  end

  def new
    @project = admin_project
    @category = Category.new
  end

  def create
    @project = Project.find(params[:project_id])
    @category = @project.categories.build(category_params)
    if @category.save
      redirect_to project_categories_path(@project), notice: "カテゴリを作成しました"
    else
      flash[:alert] = "カテゴリを作成できませんでした。"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @category.update(category_params)
      redirect_to project_categories_path(@category.project), notice: "カテゴリ名を編集しました"
    else
      flash[:alert] = "タイトルを入力してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    if @category == admin_choosed_category
      redirect_to project_categories_path(@category.project), alert: "active中のカテゴリは削除できません！！"
    else
      @category.destroy
      redirect_to project_categories_path(@category.project), notice: "カテゴリを削除しました"
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :project_id)
  end
end
