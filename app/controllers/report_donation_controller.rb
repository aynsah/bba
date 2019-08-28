class ReportDonationController < ApplicationController
	def monthly
		@month = params[:month]
		@reports = ReportDonation.by_month(@month)
		@donation_count = @reports.count
		@donation_total = @reports.sum(:donation_amount)
	end

	def export
		@month = params[:month]
		@reports = ReportDonation.by_month(@month)

		respond_to do |format|
			format.html { redirect_to month_product_path(@month) }
			format.xls { send_data @reports.to_csv(col_sep: "\t"), filename: "monthly-donation-report-#{Date.today}.xls" }
		end
	end
end
