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
        expect(page).to have_content('New Project')
        click_link "New Project"
        expect(page.status_code).to eq(200)
      end
    end
  end

  describe "creation" do
    before do
      login_as(user, :scope => :user)
      visit new_project_path
    end
    it "has a new form that can be reached" do
      expect(page.status_code).to eq(200)
    end
    it "can be created from new form page" do
      fill_in 'project[start_date]', with: (Date.today + 30.days)
      fill_in 'project[name]', with: "New Project"
      expect { click_on "Save" }.to change(Project, :count).by(1)
    end

    it "will have an user associated with the project" do
      fill_in 'project[start_date]', with: (Date.today + 30.days)
      fill_in 'project[name]', with: "user_association"
      click_on "Save"

      expect(User.last.projects.last.name).to eq("user_association")
    end

    it "will have a client associated with the project" do
      fill_in 'project[start_date]', with: (Date.today + 30.days)
      fill_in 'project[name]', with: "client_association"
      fill_in 'project[client]', with: "client@email.com"
      click_on "Save"

      expect(Client.last.email).to eq("client@email.com")

    end

    it "will have add an existing client to a project" do
      user = FactoryGirl.create(:user)
      project = FactoryGirl.create(:project, user_id: user.id)
      client = FactoryGirl.create(:client, project_id: project.id)
      fill_in 'project[start_date]', with: (Date.today + 30.days)
      fill_in 'project[name]', with: "client_association"
      fill_in 'project[client]', with: client.email
      click_on "Save"

      expect(Client.last.project.name).to eq("client_association")

    end
  end
end
