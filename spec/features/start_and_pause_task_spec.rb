require "rails_helper"

describe "start, pause, resume, and complete tasks" do
  before do
    @user = FactoryGirl.create(:user, availability: 10)
    @project = FactoryGirl.create(:project, user_id: @user.id, start_date: Date.today)

    @task = Task.create(name:"task_1", project_id: @project.id, estimated_start_date: Date.today, duration: 10)
    @task.calculate_end_date
    @task1 = Task.create(name:"task_2", project_id: @project.id, estimated_start_date: Date.today, duration: 15)
    @task1.calculate_end_date
    @task2 = Task.create(name:"task_3", project_id: @project.id, estimated_start_date: Date.today, duration: 5)
    @task2.calculate_end_date

    @project.calculate_project_end_date
    login_as(@user, :scope => :user)

  end
  describe "task owner can start a task and track how long it takes to complete it" do

    it "allows task owner to start a task" do
      visit project_path(@project)
      expect(@task.status).to eq("Scheduled")
      click_link("start_task_#{@task.id}")
      @task.reload
      expect(page).to have_content("task_1")
      expect(@task.actual_start_date).to eq(Date.today)
      expect(@task.status).to eq("Working")
      expect(page).to have_content("Pause")
      expect(page).to have_content("Complete Task")
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
      @task.Paused!
      visit project_task_path(@project, @task)
      click_link('Resume Task')
      @task.reload
      expect(@task.status).to eq("Working")
      expect(page).not_to have_content("Resume")
      expect(page).to have_content("Pause Task")
    end
  end
  describe "complete tasks" do
    it "allows task user to complete a task that was being worked on" do
      @task.Working!
      @task.updated_at = Time.now - 3.hours
      @task.save
      visit project_task_path(@project, @task)
      click_link('Complete Task')
      @task.reload
      expect(@task.status).to eq("Completed")
      expect(@task.actual_duration.truncate(0)).to eq(3.0)
      expect(page).not_to have_content("Resume")
      expect(page).not_to have_content("Pause Task")
      expect(current_path).to eq(project_path(@project))
    end
    it "allows task user to complete a task that was paused" do
      @task.Paused!
      @task.updated_at = Time.now - 3.hours
      @task.save
      visit project_task_path(@project, @task)
      click_link('Complete Task')
      @task.reload
      expect(@task.status).to eq("Completed")
      expect(@task.actual_duration.truncate(0)).to eq(3.0)
      expect(page).not_to have_content("Resume")
      expect(page).not_to have_content("Pause Task")
      expect(current_path).to eq(project_path(@project))
    end
    it "does not allow a user to complete a task that is already completed" do
      @task.Completed!
      visit project_task_path(@project, @task)
      expect(page).not_to have_content("Resume")
      expect(page).not_to have_content("Pause Task")
      expect(page).not_to have_content("Complete Task")
    end
  end
end
