class UsersController < ApplicationController
  def index
    @user = User.find(params[:id])
    @campaigns = Campaign.where("user_id = ?", "#{current_user.id}")
    @complaints = CampaignComplaint.where("user_id = ?", "#{current_user.id}")
  end
end
