class UsersController < ApplicationController
  def index
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      @campaigns = Campaign.where("user_id = ?", "#{current_user.id}")
      @complaints = CampaignComplaint.where("user_id = ?", "#{current_user.id}")
      @donations = Donation.where(:user_id => current_user.id).order(:created_at)
    end
  end
end
