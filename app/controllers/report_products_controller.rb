class ReportProductsController < ApplicationController
	def monthly
		@month = params[:month]
		@reports = ReportProduct.by_month(@month)
		@quantity = ReportProduct.by_month(@month).sum(:quantity)
		@price = ReportProduct.by_month(@month).sum(:price)
	end
end
