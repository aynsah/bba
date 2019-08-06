class NewsletterMailer < ApplicationMailer
  def send_mail
    @email = params[:email]
    @campaign = params[:campaign]
    make_bootstrap_mail(
    	from: 'BBA <bba@email.com>',
    	bcc: @email, 
    	subject: 'New Campaign on BBA'
    )
  end
end
