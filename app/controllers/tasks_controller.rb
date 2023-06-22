class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :not_logged_in

  PER = 10
  def index

    if params[:sort_expired]
      @tasks = current_user.tasks.order("limit_date DESC").page(params[:page]).per(PER)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order("priority ASC").page(params[:page]).per(PER)
    elsif
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(PER)
    end


    if params[:search].present?
      if params[:title].present? && params[:status].present?
        @tasks = current_user.tasks.get_by_title(params[:title]).get_by_status(params[:status]).page(params[:page]).per(PER)
      elsif params[:title].present?
        @tasks = current_user.tasks.get_by_title(params[:title]).page(params[:page]).per(PER)
      elsif params[:status].present?
        @tasks = current_user.tasks.get_by_status(params[:status]).page(params[:page]).per(PER)
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
      @task = current_user.tasks.build(task_params)
      if @task.save
        redirect_to tasks_path(@task.id), notice: "タスクを作成しました!"
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path, notice: "タスクを編集しました！"
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
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :title, :content, :limit_date, :status, :priority, label_ids: [] )
  end
end
