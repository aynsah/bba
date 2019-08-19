class NewsletterMailer < ApplicationMailer
  def send_mail
    @email = params[:email]
    @campaign = params[:campaign]
    attachments.inline["img"] = File.read(Rails.root.join("public/#{@campaign.image_campaign.url}"))
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
