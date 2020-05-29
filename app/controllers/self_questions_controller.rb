class SelfQuestionsController < ApplicationController
  skip_before_action :admin_login_required

  def index
    @search = Question.where(user_id: current_user).ransack(params[:q])
    @questions = @search.result.order(created_at: :desc)
  end
end
