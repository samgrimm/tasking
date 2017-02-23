require 'rails_helper'

describe 'navigate' do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user_id: user.id) }
  let(:task) { FactoryGirl.create(:task, project_id: project.id) }
  describe 'index' do
    before do
      login_as(user, :scope => :user)
    end
    it 'can be reached successfully' do
      visit project_tasks_path(project)
      expect(page.status_code).to eq(200)
    end
    it 'has a title of Daily Report' do
      visit project_tasks_path(project)
      expect(page).to have_content("Daily Report")
    end

    it 'has a list of Tasks worked on that day' do
      task1 = FactoryGirl.create(:task, project_id: project.id, name: "First Task", updated_at: Date.today)
      task2 = FactoryGirl.create(:task, project_id: project.id, name: "Second Task", updated_at: Date.today)
      visit project_tasks_path(project)
      expect(page).to have_content(/First Task|Second Task/)
    end

    it "has a scope so that only Project owner can see their tasks" do
      other_user = FactoryGirl.create(:user)
      task1 = FactoryGirl.create(:task, project_id: project.id, name: "First Task", updated_at: Date.today)
      task2 = FactoryGirl.create(:task, project_id: project.id, name: "Second Task", updated_at: Date.today)
      other_project = FactoryGirl.create(:project, user_id: other_user.id)
      task_from_other_user = FactoryGirl.create(:task, project_id: other_project.id, name: "Another project task")
      visit project_tasks_path(project)
      expect(page).to have_content(/First Task|Second Task/)
      expect(page).not_to have_content(/Another project task/)
    end
    describe "new" do
      it "has a link from the project's page" do
        visit project_path(project)
        expect(page).to have_content('Add a task')
        click_link "Add a task"
        expect(page.status_code).to eq(200)
      end
    end
  end

  describe "creation" do
    before do
      login_as(user, :scope => :user)
      visit new_project_task_path(project)
    end
    it "has a new form that can be reached" do
      expect(page.status_code).to eq(200)
    end
    it "can be created from new form page" do
      fill_in 'task[name]', with: "New Task"
      fill_in 'task[estimated_start_date]', with: (Date.today + 2.days)
      fill_in 'task[duration]', with: (40)
      expect { click_on "Save" }.to change(Task, :count).by(1)
    end

    it "will have a project associated with the task" do
      fill_in 'task[estimated_start_date]', with: (Date.today + 2.days)
      fill_in 'task[duration]', with: (30)
      fill_in 'task[name]', with: "project_association"
      click_on "Save"

      expect(Project.last.tasks.last.name).to eq("project_association")
    end
  end
  describe "updating" do
    before do
      login_as(user, :scope => :user)
      @task1 = FactoryGirl.create(:task, project_id: project.id, name: "First Task")
      visit edit_project_task_path(project, @task1)
    end
    it "has an edit form that can be reached" do
      expect(page.status_code).to eq(200)
    end
    it "can be updated from edit form page" do
      fill_in 'task[name]', with: "Edited Task"
      fill_in 'task[estimated_start_date]', with: (Date.today + 3.days)
      fill_in 'task[duration]', with: (40)
      click_on "Save"
      @task1.reload
      expect(@task1.name).to eq("Edited Task")
      expect(@task1.estimated_end_date).to eq(Date.today + 8.days)
    end

  end
end
