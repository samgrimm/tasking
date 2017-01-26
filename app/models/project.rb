class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks
  has_one :client

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

  def send_report
    ClientMailer.report(self).deliver
  end

  def add_client email
    if Client.find_by(email: email)
      client = Client.find_by(email: email)
    else
      random_password = SecureRandom.hex
      client = Client.new(email: email, password: random_password, password_confirmation: random_password)
    end
    client.project_id = self.id
    client.save
  end

  def complete_project
    self.Completed!
    self.actual_end_date = self.updated_at
    self.save
  end

end
