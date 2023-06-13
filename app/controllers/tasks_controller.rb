class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @choose_new_or_edit = tasks_path
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path(@task.id), notice: "タスクを作成しました!"
      else
        render :new
      end
    end
  end

  def edit
    @choose_new_or_edit = tasks_path
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task.id), notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  def confirm

  end

  private

  def set_task
  @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content)
  end
end
