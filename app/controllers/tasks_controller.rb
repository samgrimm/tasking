class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :start ]
  before_action :set_project
  def index
    @tasks = @project.tasks
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

  def show
  end

  def start
    @task.actual_start_date = Date.today
    if @task.save
      redirect_to project_task_path(@project, @task), notice: "You are currently working on #{@task.name}"
    else
      #do something
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
