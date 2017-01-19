module ProjectsHelper

  def percent_complete project
    total_hours = project.tasks.sum(:duration)
    completed_hours = project.tasks.where(status: "Completed").sum(:duration)
    percent_complete = (completed_hours/total_hours)*100
    return percent_complete.truncate(0).to_s + "%"
  end
end
