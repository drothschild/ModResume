class VisitorMailer < ApplicationMailer
  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(from: ENV['GMAIL_EMAIL'],
         to: 'gary_wong_89@yahoo.com',
         subject: 'New User\'s Email')
  end
end
