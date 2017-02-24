require "rails_helper"

RSpec.describe ClientMailer, type: :mailer do
  describe "report" do
    let(:user) { FactoryGirl.create(:user) }
    let(:client) { FactoryGirl.create(:client) }
    let(:project) { FactoryGirl.create(:project, user: user, client: client) }
    let(:task) { FactoryGirl.create(:task, project: project) }
    let(:mail) { ClientMailer.report(project) }

    it "renders the headers" do
      expect(mail.subject).to eq("Report for #{project.name}")
      expect(mail.to).to eq([client.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi, here is your daily report.")
    end
  end

end
