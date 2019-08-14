class DonationsController < ApplicationController
	before_action :set_donation

	def show
	end

	def cek
		@donation = Donation.where("order_id = ?", params[:id]).first
		render :action => 'show'
	end

	private
		def set_donation
			@donation = Donation.find_by_id(params[:id])
		end
end
