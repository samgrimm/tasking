require "rails_helper"

describe "start and pause tasks" do
  describe "task owner can start a task and track how long it takes to complete it" do
    before do
      @user = FactoryGirl.create(:user, availability: 10)
      @project = FactoryGirl.create(:project, user_id: @user.id, start_date: Date.today)

      @task = Task.create(name:"task_1", project_id: @project.id, estimated_start_date: Date.today, duration: 10)
      @task.calculate_end_date
      @task1 = Task.create(name:"task_2", project_id: @project.id, estimated_start_date: Date.today, duration: 15)
      @task1.calculate_end_date
      @task2 = Task.create(name:"task_2", project_id: @project.id, estimated_start_date: Date.today, duration: 5)
      @task2.calculate_end_date

      @project.calculate_project_end_date
      login_as(@user, :scope => :user)

    end
    it "allows task owner to start a task" do
      visit project_path(@project)
      click_link('start_task_1')
      @task.reload
      expect(page).to have_content("task_1")
      expect(@task.actual_start_date).to eq(Date.today)
      expect(@task.status).to eq("Working")
      expect(page).to have_content("Pause")
      expect(page).to have_content("End Task")
    end
    it "allows task owner to pause a task" do
      @task.Working!
      @task.updated_at = Time.now - 3.hours
      @task.save
      visit project_task_path(@project, @task)
      click_link('Pause Task')
      @task.reload
      expect(@task.actual_duration.truncate(0)).to eq(3.0)
      expect(@task.status).to eq("Paused")
      expect(page).to have_content("Resume")
      expect(page).not_to have_content("Pause Task")
    end

    it "allows task owner to resume a task that was paused" do
      visit project_task_path(@project, @task)
      click_link('Resume Task')
      @task.reload
      expect(@task.status).to eq("Working")
      expect(page).not_to have_content("Resume")
      expect(page).to have_content("Pause Task")
    end
  end
end
