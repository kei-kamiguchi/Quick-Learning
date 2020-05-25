class UserAnswersController < ApplicationController
  skip_before_action :admin_login_required

# スッキリしないコードだが正しく動く&付随してviewの方も曖昧な表現になっている（ある一つのtest_questionを取ってきてそこからtestを受けた全てのuserを取っている）
  def index
    @test = Test.find(params[:test])
    @test_questions = TestQuestion.where(test_id: @test.id)
    @test_question = TestQuestion.where(test_id: @test.id).first
    @user_answers = UserAnswer.where(test_question_id: @test_question)
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
        answer: value['answer']
      )
    end
    redirect_to current_user, notice: "テストが終了しました！お疲れ様です！"
  end

  def show
    @user = User.find(params[:user])
    @test = Test.find(params[:test])
    @test_questions = TestQuestion.where(test_id: @test.id)
  end

  private

# ここはセキュリティー的に大丈夫？
  def user_answers_params
    params.require(:user_answers)
  end
end
