class AnswerPapersController < ApplicationController
  skip_before_action :admin_login_required
  skip_before_action :test_entry_exit, only: [:create]

  def index
    @test = Test.find(params[:test])
    @test_questions = TestQuestion.where(test_id: @test.id)
    @test_question = @test_questions.last
    @answer_papers = AnswerPaper.where(test_question_id: @test_question).order(created_at: :asc)
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

  def show
    @answer_paper = AnswerPaper.find(params[:id])
    @test = Test.find(@answer_paper.test_id)
    @user = @answer_paper.user
    @answer_papers = AnswerPaper.where(test_id: @test.id, user_id: @user.id, backed: false).order(created_at: :asc)
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

  def answer_paper_params
    params.require(:answer_paper).permit(:advice, :memo, :answer_paper_id)
  end
# ここはセキュリティー的に大丈夫？
  def answer_papers_params
    params.require(:answer_papers)
  end
end
