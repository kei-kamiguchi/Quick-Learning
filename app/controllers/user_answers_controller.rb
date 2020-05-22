class UserAnswersController < ApplicationController
  skip_before_action :admin_login_required

  def new
    @test = Test.find(1)
    @test_questions = @test.test_questions
    @user_answers = UserAnswer.new
  end

  def create
    @user_answers = user_answers_params.values.each do |value|
      UserAnswer.create(
        user_id: value['user_id'],
        test_question_id: value['test_question_id'],
        answer: value['content']
      )
    end
  end

  private

# ここはセキュリティー的に大丈夫？
  def user_answers_params
    params.require(:user_answers)
  end
end
