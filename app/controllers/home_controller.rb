class HomeController < ApplicationController
	def index
		@campaigns = Campaign.where(:approved => true).last(3)
		@total = Campaign.count
	end
end
