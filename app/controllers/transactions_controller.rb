class TransactionsController < ApplicationController

	def index
		@transaction = Donation.all
	end

end
