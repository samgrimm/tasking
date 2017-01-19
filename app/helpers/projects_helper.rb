module ProjectsHelper

  def percent_complete project
    total_hours = project.tasks.sum(:duration)
    completed_hours = project.tasks.sum(:duration)
    percent_complete = (completed_hours/total_hours)*100
    return percent_complete.to_s + "%"
  end
end
