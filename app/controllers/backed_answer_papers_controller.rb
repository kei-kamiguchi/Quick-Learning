class BackedAnswerPapersController < ApplicationController
  skip_before_action :admin_login_required

  def index
    @backed_answer_papers = AnswerPaper.where(user_id: current_user.id, backed: true).select(:test_id).distinct
  end

  def check
    @test = Test.find(params[:test])
    @answer_papers = AnswerPaper.where(test_id: @test.id, user_id: current_user.id).order(created_at: :asc)
  end
end
