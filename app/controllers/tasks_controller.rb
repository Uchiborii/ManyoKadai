class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  PER = 10
  def index
    @tasks = Task.all.order(created_at: "DESC").page(params[:page])

    if params[:sort_expired]
      @tasks = Task.order("limit_date DESC").page(params[:page]).per(PER)
    elsif params[:sort_priority]
      @tasks = Task.order("priority ASC").page(params[:page]).per(PER)
    end


    if params[:search].present?
      if params[:title].present? && params[:status].present?
        @tasks = @tasks.get_by_title(params[:title]).get_by_status(params[:status]).page(params[:page]).per(PER)
      elsif params[:title].present?
        @tasks = @tasks.get_by_title(params[:title]).page(params[:page]).per(PER)
      elsif params[:status].present?
        @tasks = @tasks.get_by_status(params[:status]).page(params[:page]).per(PER)
      end
    end
  end


  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
    task_id = params[:id]
  end

  def create
    if params[:back]
      render :new
    else
      @task = Task.new(task_params)
      if @task.save
        redirect_to tasks_path(@task), notice: "タスクを作成しました!"
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, flash: { notice: "タスクを削除しました！" }
  end

  def confirm

  end

  private

  def set_task
  @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :limit_date, :status, :priority)
  end
end
