class VisitorMailer < ApplicationMailer
  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(from: ENV['SENDGRID_USERNAME'],
         to: @email,
         subject: 'Resume')
  end
end
