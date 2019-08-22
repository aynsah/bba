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
    put_user_data
    flash[:info] = nil

    if current_user

      @datas.each do |data|
        @filled_data_count -= 1 if current_user.send(data).nil? ||  current_user.send(data) == ""
      end

      flash[:info] = "Lengkapi data diri anda (#{@filled_data_count} / #{@datas.count})" unless @filled_data_count == @datas.count
    end
  end
end
