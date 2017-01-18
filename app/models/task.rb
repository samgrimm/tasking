class Task < ApplicationRecord
  belongs_to :project
  enum status: {Scheduled: 0, Working: 1, Paused: 2, Completed: 3}

  def calculate_end_date
    total_days = self.duration/self.project.user.availability
    self.estimated_end_date = self.estimated_start_date + total_days.days
    self.save
  end

  def pause_task
    self.status = "Paused"
    last_update = self.updated_at
    self.save
    calc_duration = (self.updated_at - last_update) / 3600
    self.actual_duration = self.actual_duration + calc_duration
  end

end
