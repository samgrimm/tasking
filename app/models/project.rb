class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks

  scope :projects_by, -> (user) { where(user_id: user.id) }

  def calculate_project_end_date
    self.end_date = tasks.maximum(:estimated_end_date)
    self.save
  end
end
