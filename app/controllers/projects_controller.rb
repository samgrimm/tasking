class ProjectsController < ApplicationController
  before_action :authenticate_user!

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
      redirect_to @project, notice: "Your project was created successfully"
    else
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  private


  def project_params
    params.require(:project).permit(:name, :start_date)
  end
end
