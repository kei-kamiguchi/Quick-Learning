class CategoriesController < ApplicationController
  skip_before_action :admin_login_required
  before_action :set_category, only: [:edit, :destroy, :update]

  def index
    @category = Category.new
    @project = admin_project
    if admin_signed_in?
      @categories = Category.where(project_id: admin_project.id)
    end
    if user_signed_in?
      @categories = Category.where(project_id: user_project.id)
    end
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
      render 'new'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to project_categories_path(@category.project), notice: "カテゴリ名を編集しました"
    else
      flash[:alert] = "タイトルを入力してください。"
      render 'edit'
    end
  end

  def destroy
    unless @category == admin_choice_category
      @category.destroy
      redirect_to project_categories_path(@category.project), notice: "カテゴリを削除しました"
    else
      redirect_to project_categories_path(@category.project), alert: "active中のカテゴリは削除できません！！"
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
