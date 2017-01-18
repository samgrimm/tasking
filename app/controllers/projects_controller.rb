class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.projects_by(current_user)
  end

  def new
    @project = Project.new
  end

  private


  def project_params
    params.require(:project).permit(:name, :start_date)
  end
end
