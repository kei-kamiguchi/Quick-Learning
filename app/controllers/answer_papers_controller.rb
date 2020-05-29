class AnswerPapersController < ApplicationController
  skip_before_action :admin_login_required
  skip_before_action :test_entry_exit, only: [:create]
  before_action :set_test, only: [:index, :check, :back]

  def index
    @test_questions = TestQuestion.where(test_id: @test.id).rank(:row_order)
    @test_question = @test_questions.last
    @answer_papers = AnswerPaper.where(test_question_id: @test_question)
  end

  def create
    @answer_papers = answer_papers_params.values.each do |value|
      AnswerPaper.create(
        user_id: value['user_id'],
        test_question_id: value['test_question_id'],
        test_id: value['test_id'],
        test_title: value['test_title'],
        title: value['title'],
        content: value['content'],
        correct_answer: value['correct_answer'],
        answer: value['answer']
      )
    end
    redirect_to current_user, notice: "テストが終了しました！お疲れ様です！"
  end

  def check
    @answer_papers = AnswerPaper.where(test_id: @test.id, user_id: params[:user]).order(created_at: :asc)
  end

  def update
    @answer_paper = AnswerPaper.find(params[:id])
    respond_to do |format|
      if @answer_paper.update(answer_paper_params)
        @answer_paper.toggle_edit!
        format.js { render :advice } if answer_paper_params.has_key?(:advice)
        format.js { render :memo } if answer_paper_params.has_key?(:memo)
      else
        format.html { redirect_to check_answer_papers_path, alert: '投稿できませんでした。' }
      end
    end
  end

  def back
    if params.has_key?(:user)
      @user = User.find(params[:user])
      @answer_paper = AnswerPaper.where(test_id: @test.id, user_id: @user.id)
    else
      @answer_paper = AnswerPaper.where(test_id: @test.id)
    end
    @answer_paper.update_all(backed: true)
    redirect_to project_tests_path(admin_project)
  end

  def toggle_edit
    @answer_paper = AnswerPaper.find(params[:id] || params[:answer_paper_id])
    respond_to do |format|
      if @answer_paper.toggle_edit!
        format.js { render :advice } if @answer_paper.backed == false
        format.js { render :memo } if @answer_paper.backed == true
      else
        format.html { redirect_to check_answer_papers_path, alert: '投稿できませんでした。' }
      end
    end
  end

  def toggle_checked
    @answer_paper = AnswerPaper.find(params[:id] || params[:answer_paper_id])
    @answer_paper.toggle_checked!
    redirect_to answer_papers_path(test: params[:test])
  end

  private

  def set_test
    @test = Test.find(params[:test])
  end

  def answer_paper_params
    params.require(:answer_paper).permit(:advice, :memo, :answer_paper_id)
  end
# ここはセキュリティー的に大丈夫？
  def answer_papers_params
    params.require(:answer_papers)
  end
end
