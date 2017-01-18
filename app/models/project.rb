class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks

  scope :projects_by, -> (user) { where(user_id: user.id) }
end
