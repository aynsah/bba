class CekResiController < ApplicationController
	def index

	end

	def cek
		@transaction = Veritrans.status(params[:resi])
		if @transaction.status_code == 404
			redirect_to( cek_resi_path, alert: 'Transaksi tidak tersedia mohon periksa kembali Order ID yang dimasukan')
		end
	end

	def error
	end
end
