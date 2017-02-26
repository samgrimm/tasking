class Client < User
  has_many :projects

  def self.by_user(user)
    joins(:projects).where('projects.user_id' => user.id).uniq
  end
end
