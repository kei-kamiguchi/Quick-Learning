class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  skip_before_action :admin_login_required

  def create
    @question = Question.find(params[:question_id])
    @comment = @question.comments.build(comment_params)
    @comment.user_id = current_user.id if user_signed_in?
    @comment.admin_id = current_admin.id if admin_signed_in?
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to question_path(@question), alert: 'コメントが投稿できませんでした。' }
      end
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to ({controller: :questions, action: :show, id: @comment.question.id}), notice: 'コメントを編集しました！'
    else
      flash[:alert] = "コメントを更新できません！"
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "コメントを削除しました！"
    redirect_back(fallback_location: root_path)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:question_id, :content)
  end
end
