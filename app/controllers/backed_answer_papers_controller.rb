class BackedAnswerPapersController < ApplicationController
  skip_before_action :admin_login_required

  def index
    @backed_answer_papers = AnswerPaper.where(user_id: current_user.id, backed: true).select(:test_id).distinct
  end

  def new
    @test = Test.find(params[:test])
    if params.has_key?(:user)
      @answer_paper = AnswerPaper.where(test_id: @test.id, user_id: params[:user])
      @answer_paper.update(backed: true)
    else
      @answer_papers = AnswerPaper.where(test_id: @test.id)
      @answer_papers.update_all(backed: true)
    end
    redirect_to project_tests_path(admin_project)
  end

  def show
    @test = AnswerPaper.find_by(test_id: params[:test_id])
    @answer_papers = AnswerPaper.where(test_id: params[:test_id], user_id: current_user.id)
  end
end
