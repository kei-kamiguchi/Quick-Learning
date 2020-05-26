class TestQuestionsController < ApplicationController
  before_action :set_test_question, only: [:show, :edit, :update, :destroy]
  before_action :set_test, only: [:index, :new, :create]

  def index
    @test_questions = @test.test_questions.rank(:row_order)
  end

  def new
    @test_question = TestQuestion.new
  end

  def create
    @test_question = @test.test_questions.build(test_question_params)
    if @test_question.save
      redirect_to test_test_questions_path(@test), notice: "問題を作成しました！"
    else
      flash[:alert] = "問題を作成できませんでした。"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @test_question.update(test_question_params)
      redirect_to test_test_questions_path(@test_question.test), notice: "問題を更新しました！"
    else
      flash[:alert] = "問題を更新できませんでした。"
      render 'edit'
    end
  end

  def destroy
    @test_question.destroy
    flash[:notice] = "問題を削除しました。"
    redirect_back(fallback_location: root_path)
  end

  def update_row_order
    @test_question = TestQuestion.find(test_question_params[:test_question_id])
    @test_question.row_order_position = test_question_params[:row_order_position]
    @test_question.save

    render body: nil
  end

  private

  def set_test_question
    @test_question = TestQuestion.find(params[:id])
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

  def test_question_params
    params.require(:test_question).permit(:test_id, :title, :content, :correct_answer, :form_size, :row_order_position, :test_question_id)
  end
end
