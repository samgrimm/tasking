class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :start, :pause , :resume, :complete, :edit, :update]
  before_action :set_project
  layout 'project'
  def index
    @tasks = @project.tasks.where(updated_at: Date.today)
  end

  def new
    @task = Task.new
  end

  def create
    @task = @project.tasks.build(task_params)
    if @task.save
      @task.calculate_end_date
      redirect_to @project, notice: "Your task was added successfully"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      @task.calculate_end_date
      redirect_to @project, notice: "Your task was updated successfully"
    else
      render 'edit'
    end
  end

  def show
  end

  def start
    @task.actual_start_date = Date.today
    @task.status = "Working"
    if @task.save
      redirect_to project_task_path(@project, @task), notice: "You are currently working on #{@task.name}"
    else
      #do something
    end
  end

  def pause
    @task.pause_task
    if @task.save
      redirect_to project_task_path(@project, @task), notice: "You have paused work on #{@task.name}"
    else
      #do something
    end
  end

  def resume
    @task.Working!
    redirect_to project_task_path(@project, @task), notice: "You have resumed work on #{@task.name}"
  end

  def complete
    @task.complete_task
    if @task.save
      redirect_to project_path(@project), notice: "You have completed work on #{@task.name}"
    else
      # do something
    end
  end

  private
  def task_params
    params.require(:task).permit(:name, :estimated_start_date, :duration)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
