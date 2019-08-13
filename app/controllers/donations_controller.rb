class DonationController < ApplicationController
	before_action :set_product

	def show
	end

	private
		def set_donation
			@donation = Donation.find(params[:id])
		end
end
