class CommentsController < ApplicationController
  before_action :set_comment, only: [:create]
  skip_before_action :admin_login_required

  def create
    @comment = @question.comments.build(comment_params)
    if user_signed_in?
      @comment.user_id = current_user.id
    end
    if admin_signed_in?
      @comment.admin_id = current_admin.id
    end
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to question_path(@question), alert: 'コメントが投稿できませんでした。' }
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to controller: 'questions', action: 'show', id: @comment.question.id, notice: 'コメントを編集しました！'
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end


  private

  def set_comment
    # @project = Project.find(params[:project_id])
    # @subject = Subject.find(params[:subject_id])
    # @part = Part.find(params[:part_id])
    @question = Question.find(params[:question_id])
  end

  def comment_params
    params.require(:comment).permit(:project_id, :subject_id, :part_id, :question_id, :content)
  end
end
