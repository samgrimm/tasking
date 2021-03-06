class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks
  belongs_to :client, optional: true

  enum status: {Scheduled: 0, Paused: 1, Completed: 2, Cancelled: 3 }

  scope :projects_by, -> (user) { where(user_id: user.id) }

  scope :scheduled?, -> { where(status: 0) }
  scope :paused?, -> { where(status: 1) }
  scope :completed?, -> { where(status: 2) }
  scope :cancelled?, -> { where(status: 3) }

  def calculate_project_end_date
    self.end_date = tasks.maximum(:estimated_end_date)
    self.save
  end

  def tasks_completed
    tasks.where(status: 3, updated_at: (Date.today - 6.days)).count
  end

  def pause_tasks
    tasks.each do |task|
      task.Paused!
    end
  end

  def send_report
    ClientMailer.report(self).deliver
  end

  def add_client email
    if Client.find_by(email: email)
      client = Client.find_by(email: email)
    else
      random_password = SecureRandom.hex
      client = Client.new(email: email, password: random_password, password_confirmation: random_password)
      client.save
    end
    self.client_id = client.id
    self.save
  end

  def complete_project
    self.Completed!
    self.actual_end_date = self.updated_at
    self.save
  end

  def tasks_worked_today
    tasks = self.tasks.where("updated_at < ? ", (Date.today - 1.days))
  end

  def percent_complete
    total_hours = tasks.sum(:duration)
    if total_hours == 0
      percent_complete = 0.00
    else
      completed_hours = tasks.where(status: "Completed").sum(:duration)
      percent_complete = (completed_hours/total_hours)*100
    end
    return percent_complete.to_s + "%"
  end

end
