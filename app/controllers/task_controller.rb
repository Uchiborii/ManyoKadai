class TaskController < ApplicationController
  def new
    @task = Task.new
  end

  def index
    @task = Task.all
  end

  def show
    @task = Task.new(params[id])
  end

  def create
    @task = Task.new
  end

  def edit
    @task = Task.find(params[id])
  end

  def update
    @task = Task.find(params[id])
  end

  def destroy
    @task = Task.find(params[id])
  end

  private

  def task_params
    @task = task_params(params[id])
  end
end
