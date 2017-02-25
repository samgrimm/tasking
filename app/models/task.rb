class Task < ApplicationRecord
  belongs_to :project
  enum status: {Scheduled: 0, Working: 1, Paused: 2, Completed: 3}

  def calculate_end_date
    total_days = self.duration/self.project.user.availability
    self.estimated_end_date = self.estimated_start_date + total_days.days
    self.save
  end
# needs refactoring

  def calculate_duration
    last_time_tracker = self.time_tracker
    calc_duration = DateTime.now.to_f - last_time_tracker.to_f
    self.actual_duration = self.actual_duration + calc_duration
    self.time_tracker = DateTime.now
  end
  def pause_task
    self.status = "Paused"
    self.calculate_duration
    self.save
  end

  def start_task
    self.status = "Working"
    self.time_tracker = DateTime.now
    self.save
  end

  def resume_task
    self.status = "Working"
    self.time_tracker = DateTime.now
    self.save
  end

  def complete_task
    self.status = "Completed"
    self.calculate_duration
    self.save
  end

end
