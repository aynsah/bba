class HomeController < ApplicationController
	def index
    check_data
    sign_in(User.find(params[:id]), scope: :user) if params[:id]
		@campaigns = Campaign.where(:status => "approved").last(3)
		@total = Campaign.where(:status => "approved").count
	end

	def cek_resi
	end

  def check_data
    filled_data_count = 4
    flash[:info] = nil

    if current_user
      filled_data_count -= 1 if current_user.photo.nil? ||  current_user.photo == ""
      filled_data_count -= 1 if current_user.address.nil? ||  current_user.address == ""
      filled_data_count -= 1 if current_user.phone.nil? ||  current_user.phone == ""
      filled_data_count -= 1 if current_user.bio.nil? ||  current_user.bio == ""

      flash[:info] = "Lengkapi data diri anda (#{filled_data_count} / 4)" unless filled_data_count == 4
    end
  end
end
