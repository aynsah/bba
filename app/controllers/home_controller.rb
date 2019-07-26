class HomeController < ApplicationController
	def index
		@campaigns = Campaign.last(3)
		@total = Campaign.count
	end
end
