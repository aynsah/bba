class ReportProductsController < ApplicationController

	def monthly
		@month = params[:month]
		@reports = ReportProduct.by_month(@month)
		@quantity = ReportProduct.by_month(@month).sum(:quantity)
		@price = ReportProduct.by_month(@month).sum(:price)
	end

	def export
		@month = params[:month]
		@reports = ReportProduct.by_month(@month)

		respond_to do |format|
			format.html { redirect_to month_product_path(@month) }
			format.csv { send_data @reports.to_csv, filename: "monthly-product-report-#{Date.today}.csv"}
			format.xls { send_data @reports.to_csv(col_sep: "\t") }
		end
	end
end
