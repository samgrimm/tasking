require 'rails_helper'

describe 'navigate' do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user_id: user.id) }
  describe 'index' do
    before do
      login_as(user, :scope => :user)
    end
    it 'can be reached successfully' do
      visit projects_path
      expect(page.status_code).to eq(200)
    end
    it 'has a title of Projects' do
      visit projects_path
      expect(page).to have_content("Projects")
    end

    it 'has a list of Posts' do
      project1 = FactoryGirl.create(:project, user_id: user.id, name: "First Project")
      project2 = FactoryGirl.create(:project, user_id: user.id, name: "Second Project")
      visit projects_path
      expect(page).to have_content(/First Project|Second Project/)
    end

    it "has a scope so that only project creators can see their projects" do
      other_user = FactoryGirl.create(:user)
      project1 = FactoryGirl.create(:project, user_id: user.id, name: "First Project")
      project2 = FactoryGirl.create(:project, user_id: user.id, name: "Second Project")
      project_from_other_user = FactoryGirl.create(:project, user_id: other_user.id, name: "Another user")
      visit projects_path
      expect(page).to have_content(/First Project|Second Project/)
      expect(page).not_to have_content(/Another user/)
    end
    describe "new" do
      it "has a link from the homepage" do
        visit root_path
        expect(page).to have_content('Create a project')
        click_link "new_project_from_nav"
        expect(page.status_code).to eq(200)
      end
    end
  end
end
