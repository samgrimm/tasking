class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks
  has_one :client

  scope :projects_by, -> (user) { where(user_id: user.id) }

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

end
