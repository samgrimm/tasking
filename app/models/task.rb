class Task < ApplicationRecord
  belongs_to :project

  def calculate_end_date
    total_days = self.duration/self.project.user.availability
    self.estimated_end_date = self.estimated_start_date + total_days.days
    self.save
  end
end
