class HomeController < ApplicationController
	def index
		@products = Product.order('id ASC').all

		#if current_user.admin == true
		#	redirect_to rails_admin_path
		#end
	end
end
