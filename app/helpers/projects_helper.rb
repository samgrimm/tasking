module ProjectsHelper

  def icon_helper status
    icon = case status
      when "Scheduled" then fa_icon "calendar 4x"
      when "Paused" then fa_icon "pause 4x"
      when "Cancelled" then fa_icon "ban 4x"
      when "Completed" then fa_icon "check-circle 4x"
    end
    icon
  end

  def background_helper status
    background = case status
      when "Scheduled" then "bg-primary"
      when "Paused" then "bg-warning"
      when "Cancelled" then "bg-faded"
      when "Completed" then "bg-success"
    end
    background
  end

  def total_hours project
    total_hours = project.tasks.sum(:duration)
  end
  def completed_hours project
    completed_hours = project.tasks.sum(:actual_duration)
  end

  def percent_complete project
    total_hours = total_hours project
    if total_hours == 0
      percent_complete = 0.00
    else
      completed_hours = project.tasks.where(status: "Completed").sum(:duration)
      percent_complete = (completed_hours/total_hours)*100
    end
    return percent_complete.to_s + "%"
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
