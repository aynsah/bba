class HomeController < ApplicationController
	def index
		@campaigns = Campaign.last(2)
		@total = Campaign.count
	end
end
