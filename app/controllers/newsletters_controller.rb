class NewslettersController < ApplicationController
	skip_before_action :verify_authenticity_token
	
	def index
	end

	def create
		@emails = User.where("subscribed = true").pluck(:email)

		NewsletterMailer.with(email: @email).send_mail.deliver_later

		redirect_to root_path, notice: 'Mails was successfully sent.'
	end
end
