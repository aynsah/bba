class UsersController < ApplicationController
  def index
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      @campaigns = Campaign.where("user_id = ?", "#{params[:id]}")
      @complaints = CampaignComplaint.where("user_id = ?", "#{params[:id]}")
      @donations = Donation.where(:user_id => params[:id]).order(:created_at)
    end
  end
end
