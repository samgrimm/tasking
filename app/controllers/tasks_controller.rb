class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show ]
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
