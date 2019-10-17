# Preview all emails at http://localhost:3000/rails/mailers/corporation_mailer
class CorporationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/corporation_mailer/confirmation
  def confirmation
    CorporationMailer.confirmation
  end

end
