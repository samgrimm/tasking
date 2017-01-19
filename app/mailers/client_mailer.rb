class ClientMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.client_mailer.report.subject
  #
  def report(project)
    @project = project
    mail to: @project.client.email
  end
end
