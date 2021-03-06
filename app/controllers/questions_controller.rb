class QuestionsController < ApplicationController
  skip_before_action :admin_login_required
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_part, only: [:create, :new]

  def index
    if user_signed_in?
      @search = Question.includes(part: [subject: :project]).where(projects: {id: user_project.id}).ransack(params[:q])
    else
      @search = Question.includes(part: [subject: :project]).where(projects: {id: admin_project.id}).where(solved: false).ransack(params[:q])
    end
    @questions = @search.result.order(created_at: :desc)
  end

  def new
    @question = Question.new
  end

  def create
    @question = @part.questions.build(question_params)
    @question.user_id = current_user.id
    if @question.save
      NotificationMailer.question_to_admin_mail(@question).deliver
      redirect_to part_path(@part), notice: "投稿しました"
    else
      render 'new'
    end
  end

  def show
    if admin_signed_in? && @question.checked_by_admin == false || admin_signed_in? && @question.checker = ""
      @question.update(checked_by_admin: true, checker: current_admin.name)
    end
    if user_signed_in? && @question.checked_by_user == false
      @question.update(checked_by_user: true)
    end
    @comments = @question.comments
    @comment = @question.comments.build
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to self_questions_path, notice: '質問を解決にしました！' if @question.solved == true
      redirect_to question_path(@question), notice: '質問を編集しました！' if @question.solved == false
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    redirect_to self_questions_path, notice: '質問を削除しました！'
  end

  private

  def set_part
    @part = Part.find(params[:part_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, :part_id, :checked_by_admin, :checked_by_user, :checker, :reply, :project_id, :solved)
  end
end
