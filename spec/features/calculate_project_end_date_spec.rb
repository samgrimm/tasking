require 'rails_helper'

describe 'project end date' do
  before do
    @user = FactoryGirl.create(:user, availability: 5)
    @project = FactoryGirl.create(:project, user_id: @user.id, start_date: Date.today)
  end
  it "will calculate an end date based on availability and task duration" do
    task = Task.create(name: "Calculate Ending",
                      project_id: @project.id,
                      duration: 30,
                      estimated_start_date: Date.today)
    task2 = Task.create(name: "Calculate Ending 2",
                        project_id: @project.id,
                        duration: 40,
                        estimated_start_date: Date.tomorrow)
    task.calculate_end_date
    task2.calculate_end_date
    @project.calculate_project_end_date
    expect(@project.end_date).to eq((Date.today + 9.days))
  end
end
