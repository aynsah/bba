class HomeController < ApplicationController
	def index
    sign_in(User.find(params[:id]), scope: :user) if params[:id]
		@campaigns = Campaign.where(:status => "approved").last(3)
		@total = Campaign.where(:status => "approved").count
	end

	def cek_resi
	end
end
