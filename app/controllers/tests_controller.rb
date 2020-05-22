class TestsController < ApplicationController
  skip_before_action :admin_login_required
  before_action :set_test, only: [:show, :edit, :update, :destroy, :entry]
  before_action :set_project, only: [:index, :create]

  def index
    @subjects = Subject.includes(:tests).where(project_id: admin_project.id)
    @test = Test.new
  end

  def new
    @test = Test.new
  end

  def create
    @test = @project.tests.build(test_params)
    if @test.save
      flash[:notice] = "テストを作成しました！"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "テストを作成できませんでした。"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @test_questions = @test.test_questions
  end

  def edit
  end

  def update
    if @test.update(test_params)
      flash[:notice] = "テストを更新しました。"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "タイトルを入力してください。"
      render 'edit'
    end
  end

  def destroy
    @test.destroy
    flash[:notice] = "テストを削除しました。"
    redirect_back(fallback_location: root_path)
  end

  def active
    @tests = Test.where(project_id: user_project.id)
  end

  def entry
    @test_questions = @test.test_questions
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def test_params
    params.require(:test).permit(:project_id, :subject_id, :title)
  end
end
