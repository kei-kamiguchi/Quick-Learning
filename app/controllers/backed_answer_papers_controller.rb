class BackedAnswerPapersController < ApplicationController
  skip_before_action :admin_login_required

  def index
    @backed_answer_papers = AnswerPaper.where(user_id: current_user.id, backed: true).select(:test_id).distinct
  end

  def check
    @test = AnswerPaper.find_by(test_id: params[:test_id])
    @answer_papers = AnswerPaper.where(test_id: params[:test_id], user_id: current_user.id)
  end
end
