class DonationController < ApplicationController
	before_action :set_product

	def show
	end

	def cek
		@transaction = Veritrans.status(params[:resi])
		if @transaction.status_code == 404
			redirect_to( cek_resi_path, alert: 'Transaksi tidak tersedia mohon periksa kembali Order ID yang dimasukan')
		end
	end

	private
		def set_donation
			@donation = Donation.find(params[:id])
		end
end
