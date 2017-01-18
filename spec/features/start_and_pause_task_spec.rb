require "rails_helper"

describe "start and pause tasks" do
  describe "task owner can start a task and track how long it takes to complete it" do
    it "allows task owner to start a task" do
      user = FactoryGirl.create(:user, availability: 10)
      project = FactoryGirl.create(:project, user_id: user.id, start_date: Date.today)
      3.times do
        task = Task.create(name:"task_1", project_id: project.id, estimated_start_date: Date.today, duration: 10)
        task.calculate_end_date
      end
      project.calculate_project_end_date
      login_as(user, :scope => :user)
      visit project_path(project)
      click_link('start_task_1')
      expect(page).to have_content("task_1")
      expect(page).to have_content("Pause")
      expect(page).to have_content("End Task")
    end
  end
end
