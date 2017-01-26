module ProjectsHelper

  def percent_complete project
    total_hours = project.tasks.sum(:duration)
    completed_hours = project.tasks.where(status: "Completed").sum(:duration)
    percent_complete = (completed_hours/total_hours)*100
    return percent_complete.truncate(0).to_s + "%"
  end

  def active_tasks projects
    scheduled_tasks = 0
    working_tasks = 0
    projects.each do |project|
      scheduled_tasks = scheduled_tasks + project.tasks.where(status: 0).count
      working_tasks = working_tasks + project.tasks.where(status: 1).count
    end
    return active_tasks = scheduled_tasks + working_tasks
  end

  def tasks_behind_schedule projects
    late_tasks = 0
    projects.each do |project|
      late_tasks = late_tasks + project.tasks.where("estimated_end_date < ? AND status = ?", Date.today, 0 ).count
    end
    return late_tasks
  end

  def tasks_completed_this_week projects
    tasks = 0
    projects.each do |project|
      tasks = tasks + project.tasks.where("updated_at < ? AND status = ?", (Date.today - 7.days), 3 ).count
    end
    return tasks
  end
end
