class Task < ApplicationRecord
  belongs_to :project

  after_save :calculate_end_date

  private

  def calculate_end_date
    total_days = self.duration/self.project.user.availability
    project = self.project
    if project.end_date
      project.end_date = project.end_date + total_days.days
    else
      project.end_date = project.start_date + total_days.days
    end
    project.save
  end
end
