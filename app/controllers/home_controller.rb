class HomeController < ApplicationController
	def index
		@campaigns = Campaign.last(2)
	end
end
