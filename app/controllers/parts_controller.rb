class PartsController < ApplicationController
  skip_before_action :admin_login_required, only: [:show, :toggle_status]
  before_action :set_part, only: [:show, :edit, :update, :destroy, :toggle_status]
  before_action :set_subject, only: [:new, :create]

  def index
    @subjects = admin_project.subjects.includes(:parts)
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
    flash[:alert] = "削除しました。"
    redirect_back(fallback_location: root_path)
  end

  def toggle_status
    @part.toggle_status!
    redirect_back(fallback_location: root_path)
  end

  private

  def set_part
    @part = Part.find(params[:id])
  end

  def set_subject
    @subject = Subject.find(params[:subject_id])
  end

  def part_params
    params.require(:part).permit(:title, :content, :status, :subject_id)
  end
end
