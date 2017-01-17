class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.projects_by(current_user)
  end
end
