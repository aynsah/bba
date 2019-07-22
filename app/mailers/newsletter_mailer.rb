class NewsletterMailer < ApplicationMailer
	def send_mail(email,data,subject)
    @body = data
    mail bcc: email, subject: subject
  end
end
