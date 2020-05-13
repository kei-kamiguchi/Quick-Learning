class CategoriesController < ApplicationController
  skip_before_action :admin_login_required

  def index
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
      redirect_to categories_path, notice: "カテゴリを作成しました"
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categorys_path, notice: "カテゴリを削除しました"
  end

  private

  def category_params
    params.require(:category).permit(:title, :project_id)
  end
end
