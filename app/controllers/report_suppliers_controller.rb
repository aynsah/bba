class ReportSuppliersController < ApplicationController
	def monthly
		@month = params[:month]
		@reports = ReportSupplier.by_month(@month)
		@total = ReportSupplier.by_month(@month).count(:id)
	end
end
