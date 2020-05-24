class PartsController < ApplicationController
  skip_before_action :admin_login_required, only: [:show]
  before_action :set_part, only: [:show, :edit, :update, :destroy]
  before_action :set_subject, only: [:new, :create]

  def index
    @subjects = Subject.eager_load(:parts).where(project_id: admin_project.id).rank(:row_order)
  end

  def new
    @part=Part.new
  end

  def create
    @part = @subject.parts.build(part_params)
    respond_to do |format|
      if @part.save
        format.html { redirect_to parts_path, notice: "投稿しました!" }
        format.json { render :show, status: :created, location: @part }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @achieved = current_user.achieveds.find_by(part_id: @part.id) if user_signed_in?
  end

  def edit
  end

  def update
    respond_to do |format|
      if @part.update(part_params)
        format.html { redirect_to part_path(@part), notice: '更新しました！' }
        format.json { render :show, status: :ok, location: @part }
      else
        format.html { render :edit }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @part.destroy
    flash[:notice] = "削除しました。"
    redirect_back(fallback_location: root_path)
  end

  def update_row_order
    @part = Part.find(part_params[:part_id])
    @part.row_order_position = part_params[:row_order_position]
    @part.save

    render body: nil
  end

  private

  def set_part
    @part = Part.find(params[:id])
  end

  def set_subject
    @subject = Subject.find(params[:subject_id])
  end

  def part_params
    params.require(:part).permit(:title, :content, :subject_id, :row_order_position, :part_id)
  end
end
