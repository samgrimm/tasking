require 'rails_helper'

describe 'project status' do
    before do
      @user = FactoryGirl.create(:user)
      @project = FactoryGirl.create(:project, user_id: @user.id)
      login_as(@user, :scope => :user)
    end
    it 'project can be marked complete' do
      visit projects_path
      click_link("mark_complete_#{@project.id}")
      @project.reload
      expect(page).to have_content("Past Projects")
      expect(@project.status).to eq("Completed")
    end

    it 'project can be marked paused' do
      visit projects_path
      click_link("pause_#{@project.id}")
      @project.reload
      expect(page).to have_content("Pending Projects")
      expect(@project.status).to eq('Paused')
    end

    it 'project can be marked cancelled' do
      visit projects_path
      click_link("mark_cancelled_#{@project.id}")
      @project.reload
      expect(page).to have_content("Pending Projects")
      expect(@project.status).to eq('Cancelled')
    end

    it 'project can be restarted' do
      @project.Paused!
      visit projects_path
      click_link("resume_#{@project.id}")
      @project.reload
      expect(@project.status).to eq('Scheduled')
    end
end
