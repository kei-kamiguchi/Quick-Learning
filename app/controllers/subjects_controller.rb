class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:index, :create]

  def index
    # @project = Project.includes(categories: :subjects).where(project_id: admin_project.id)
    @categories = Category.where(project_id: admin_project.id)
    @subject = Subject.new
  end

  def new
    @subject = Subject.new
  end

  def show
    @parts = @subject.parts
  end

  def edit
    @project = admin_project
  end

  def create
    @subject = @project.subjects.build(subject_params)
    if @subject.save
      flash[:notice] = "サブジェクトを作成しました！"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "サブジェクトを作成できませんでした。"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @subject.update(subject_params)
      flash[:notice] = "サブジェクトを更新しました。"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "タイトルを入力してください。"
      render 'edit'
    end
  end

  def destroy
    @subject.destroy
    flash[:notice] = "サブジェクトを削除しました。"
    redirect_back(fallback_location: root_path)
  end

  def update_row_order
    @subject = Subject.find(subject_params[:subject_id])
    @subject.row_order_position = subject_params[:row_order_position]
    @subject.save

    render body: nil
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def subject_params
    params.require(:subject).permit(:project_id, :category_id, :title, :row_order_position, :subject_id)
  end
end
