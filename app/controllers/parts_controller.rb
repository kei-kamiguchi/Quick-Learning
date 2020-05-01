class PartsController < ApplicationController
  before_action :set_part, only: [:show, :edit, :update, :destroy, :toggle_status]
  skip_before_action :admin_login_required, only: [:show, :toggle_status]

  def index
    @project = Project.find(params[:project_id])
    @subject = Subject.find(params[:subject_id])
    @parts = Part.all.order(created_at: :desc)
  end

  def new
    @project = Project.find(params[:project_id])
    @subject = Subject.find(params[:subject_id])
    @part=Part.new
  end

  # なぜここだけredirect_toの書き方を変えないと読み込まないのか？
  def create
    @project = Project.find(params[:project_id])
    @subject = @project.subjects.find(params[:subject_id])
    @part = @subject.parts.build(part_params)

    respond_to do |format|
      if @part.save
        format.html { redirect_to project_subject_parts_path, notice: "投稿しました!" }
        format.json { render :show, status: :created, location: @part }
      else
        format.html { render :new }
        format.json { render json: @part.errors, status: :unprocessable_entity }
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
        format.html { redirect_to project_subject_part_path(@project, @subject, @part), notice: '更新しました！' }
        format.json { render :show, status: :ok, location: @part }
      else
        format.html { render :edit }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @part.destroy
    redirect_back(fallback_location: root_path)
  end

  def toggle_status
    @part.toggle_status!
    redirect_back(fallback_location: root_path)
  end

  private

  def set_part
    @project = Project.find(params[:project_id])
    @subject = Subject.find(params[:subject_id])
    @part = Part.find(params[:id] || params[:part_id])
  end

  def part_params
    params.require(:part).permit(:title, :content, :status, :subject_id, :project_id)
  end
end
