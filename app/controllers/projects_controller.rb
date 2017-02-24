class ProjectsController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard', only: [:index, :new ]

  def index
    @projects = Project.projects_by(current_user)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      @project.add_client(params[:project][:client])
      redirect_to @project, notice: "Your project was created successfully"
    else
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
    @project.calculate_project_end_date
    @tasks = @project.tasks.order(:estimated_start_date)
    render action: "show", layout: "project"
  end

  def send_report
    @project = Project.find(params[:id])
    @project.send_report
    redirect_to project_tasks_path(@project), notice: "The Daily Report was sent to your client"
  end

  def pause
    @project = Project.find(params[:id])
    @project.Paused!
    @project.pause_tasks
    redirect_to projects_path, notice: "You have paused work on #{@project.name}"
  end

  def resume
    @project = Project.find(params[:id])
    @project.Scheduled!
    redirect_to projects_path, notice: "You have resumed work on #{@project.name}"
  end

  def complete
    @project = Project.find(params[:id])
    @project.complete_project
    redirect_to projects_path, notice: "You have completed work on #{@project.name}"
  end

  def cancel
    @project = Project.find(params[:id])
    @project.Cancelled!
    @project.pause_tasks
    redirect_to projects_path, notice: "You have cancelled #{@project.name}"
  end


  private


  def project_params
    params.require(:project).permit(:name, :start_date, :description)
  end
end
