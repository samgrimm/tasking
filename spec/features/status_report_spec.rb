require "rails_helper"

describe "create a daily status report" do
  before do
    @user = FactoryGirl.create(:user, availability: 10)

    @project = FactoryGirl.create(:project, user_id: @user.id, start_date: (Date.today - 7.days), end_date: (Date.today + 1.days))
    @client = FactoryGirl.create(:user, type:"Client", project_id: @project.id)
    @task = Task.create(name:"task_1",
                        project_id: @project.id,
                        estimated_start_date: (Date.today - 7.days),
                        duration: 10,
                        actual_duration: 20,
                        actual_start_date: (Date.today - 6.days),
                        status: "Completed",
                        updated_at: (Date.today - 4.days))
    @task1 = Task.create(name:"task_2",
                        project_id: @project.id,
                        estimated_start_date: (Date.today - 6.days),
                        duration: 5,
                        actual_duration: 15,
                        actual_start_date: (Date.today - 3.days),
                        status: "Completed",
                        updated_at: (Date.today - 1.days))
    @task2 = Task.create(name:"task_3",
                         project_id: @project.id,
                         estimated_start_date: (Date.today - 6.days),
                         duration: 5,
                         actual_start_date: (Date.today - 1.days),
                         actual_duration: 10,
                         status: "Paused",
                         updated_at: Date.today)
    login_as(@user, :scope => :user)
  end
  it "allows project owner to see tasks that were worked on today" do
    visit project_path(@project)
    click_link('Daily Report')
    expect(page).to have_content('Daily Report')
    expect(page).to have_content(/task_3/)
    expect(page).to have_content('Percentage Completed: 75.0%')
  end
  it "allows project owner to send a report to the client" do
    visit project_tasks_path(@project)
    click_link('Send Report to Client')
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
