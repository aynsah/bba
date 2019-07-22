class NewslettersController < ApplicationController
	skip_before_action :verify_authenticity_token
	
	def index
	end

	def create
		data = params[:body]
   		subject=params[:subject]

		@emails = User.where("subcribed = true").pluck(:email)

		NewsletterMailer.send_mail(@emails,data,subject).deliver_now

		redirect_to root_path, notice: 'Mails was successfully sent.'
	end
end
