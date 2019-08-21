class NewsletterMailer < ApplicationMailer
  add_template_helper(EmailHelper)

  def send_mail
    @email = params[:email]
    @campaign = params[:campaign]
    make_bootstrap_mail(
    	from: 'BBA <bba@email.com>',
    	bcc: @email, 
    	subject: 'New Campaign on BBA'
    )
  end

  def approved_mail
  	@email = params[:email]
  	@campaign = params[:campaign]
  	make_bootstrap_mail(
  		from: 'BBA <bba@email.com>',
  		to: @email,
  		subject: 'Campaign Approved'
  	)
  end
end
