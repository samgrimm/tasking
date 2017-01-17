class Project < ApplicationRecord
  belongs_to :user

  scope :projects_by, -> (user) { where(user_id: user.id) }
end
