class TestsController < ApplicationController
  skip_before_action :admin_login_required
  before_action :set_test, only: [:show, :edit, :update, :destroy, :toggle_active]
  before_action :set_project, only: [:index, :create]

  def index
    @subjects = Subject.includes(:tests).where(project_id: admin_project.id).rank(:row_order)
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
    @test_questions = @test.test_questions.rank(:row_order)
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

  def toggle_active
    @test.toggle_active!
    if @test.active=="active"
      flash[:notice] = "「#{@test.title}」をactiveにしました！"
    end
    redirect_back(fallback_location: root_path)
  end

  def update_row_order
    @test = Test.find(test_params[:test_id])
    @test.row_order_position = test_params[:row_order_position]
    @test.save
    render body: nil
  end

  private

  def set_test
    @test = Test.find(params[:id] || params[:test_id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def test_params
    params.require(:test).permit(:project_id, :subject_id, :title, :active, :row_order_position, :test_id)
  end
end
