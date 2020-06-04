class TestingsController < ApplicationController
  skip_before_action :admin_login_required
  skip_before_action :test_entry_exit, only: [:show]

  def index
    @tests = Test.where(id: params[:tests])
  end

  def new
    NotificationMailer.test_entry_mail(admin_project).deliver
    admin_project.tests.update_all(active: 0)
    flash[:notice] = "テストを配布しました。"
    redirect_back(fallback_location: root_path)
  end

  def create
    testing = current_user.testings.create(test_id: params[:test_id])
    redirect_to testing_path(params[:test_id])
  end

  def show
    @test = Test.find(params[:id] || params[:test_id])
    @test_questions = @test.test_questions
    @testing = current_user.testings.create(test_id: @test.id)
  end
end
