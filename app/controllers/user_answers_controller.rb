class UserAnswersController < ApplicationController
  skip_before_action :admin_login_required

  def index
    @test = Test.find(params[:test])
    @user_answers = UserAnswer.where(test_id: @test.id).select(:user_id).distinct
  end
# 以下おそらく不要
  # def new
  #   @test = Test.find(params[:id])
  #   @test_questions = @test.test_questions
  #   @user_answers = UserAnswer.new
  # end

  def create
    @user_answers = user_answers_params.values.each do |value|
      UserAnswer.create(
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

  # def edit
  #   @user_answer = UserAnswer.find(params[:id])
  #   @test_title = @user_answer.test_title
  #   @user_answers = UserAnswer.where(test_id: @user_answer.test_id, user_id: @user_answer.user_id)
  # end

  def check
    @test = Test.find(params[:test])
    @user_answers = UserAnswer.where(test_id: @test.id, user_id: params[:user])
  end

  def update
    @user_answer = UserAnswer.find(params[:id])
    respond_to do |format|
      if @user_answer.update(user_answer_params)
        format.js { render :description }
      else
        format.html { redirect_to check_user_answers_path, notice: '投稿できませんでした...' }
      end
    end
  end

  private

  def user_answer_params
    params.require(:user_answer).permit(:description, :memo)
  end
# ここはセキュリティー的に大丈夫？
  def user_answers_params
    params.require(:user_answers)
  end
end
