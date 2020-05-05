class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_part, only: [:create, :new, :show, :edit, :update, :destroy]
  skip_before_action :admin_login_required


  def index
    if admin_signed_in?
      @search = Question.where(project_id: admin_project.id).ransack(params[:q])
      @questions = @search.result.order(created_at: :desc)
    end
    if user_signed_in?
      @search = Question.where(project_id: user_project.id).ransack(params[:q])
      @questions = @search.result.order(created_at: :desc)
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = @part.questions.build(question_params)
    @question.user_id = current_user.id
    @question.project_id = user_project.id
    @question.subject_id = @part.subject_id
    if @question.save
      redirect_to project_subject_part_path(@project, @subject, @part), notice: "投稿しました"
    else
      render 'new'
    end
  end

  def show
    @comments = @question.comments
    @comment = @question.comments.build
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to user_question_questions_path, notice: '質問を編集しました！'
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    redirect_to user_question_questions_path, notice: '質問を削除しました！'
  end

  def user_question
    @search = Question.joins({:part => {:subject => :project}}).ransack(params[:q])
    @questions = @search.result.order(created_at: :desc)
  end

  private

  def set_part
    @project = Project.find(params[:project_id])
    @subject = Subject.find(params[:subject_id])
    @part = Part.find(params[:part_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, :project_id, :subject_id, :part_id, :user_id)
  end
end
