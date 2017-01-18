require 'rails_helper'

describe 'project end date' do
  before do
    @user = FactoryGirl.create(:user, availability: 5)
    @project = FactoryGirl.create(:project, user_id: @user.id, start_date: Date.today)
  end
  it "will calculate an end date based on availability and task duration" do
    task = Task.create(name: "Calculate Ending", project_id: @project.id, duration: 30, estimated_start_date: Date.today)
    task.save
    expect(@project.end_date).to eq((Date.today + 6.days))
  end
end
