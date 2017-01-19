# Preview all emails at http://localhost:3000/rails/mailers/client
class ClientPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/client/report
  def report
    ClientMailer.report
  end

end
