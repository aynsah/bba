class DonationsController < ApplicationController
	before_action :set_donation, only: [:show]

	def show
	end

	private
		def set_donation
			@donation = Donation.find(params[:id])
		end
end
