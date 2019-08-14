class HomeController < ApplicationController
	def index
		@campaigns = Campaign.where(:status => "approved").last(3)
		@total = Campaign.count
	end
end
