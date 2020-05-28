class TestingsController < ApplicationController
  skip_before_action :admin_login_required
  skip_before_action :entry_reset, only: [:entry]

  def create
    testing = current_user.testings.create(test_id: params[:test_id])
    redirect_to testing_path(params[:test_id])
  end
  def destroy
    testing = current_user.testings.all.destroy
  end

  def index
    @tests = Test.where(project_id: user_project.id, active: 1)
  end

  def show
    @test = Test.find(params[:id] || params[:test_id])
    @test_questions = @test.test_questions
    @testing = current_user.testings.create(test_id: @test.id)
  end

end
