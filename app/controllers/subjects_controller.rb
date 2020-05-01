class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  def index
    @project = Project.find(params[:project_id])
    @subjects = admin_project.subjects.all.order(created_at: :desc)
    @subject = Subject.new
  end

  def new
    @subject = Subject.new
  end

  def show
    @parts = @subject.parts
    @part = @subject.parts.build
  end

  def edit
  end

  def create
    @project = Project.find(params[:project_id])
    @subject = @project.subjects.build(subject_params)

    if @subject.save
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "サブジェクトを作成できませんでした。"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @subject.update(subject_params)
      redirect_to @project, notice: "投稿しました"
    else
      flash[:alert] = "タイトルを入力してください。"
      render 'edit'
    end
  end

  def destroy
    @subject.destroy
    redirect_back(fallback_location: root_path)
  end


  private
    def set_subject
      @project = Project.find(params[:project_id])
      @subject = @project.subjects.find(params[:id])
    end

    def subject_params
      params.require(:subject).permit(:project_id, :title)
    end
end
