class UsersController < ApplicationController
  def index
    if User.where(:name => params[:name]).any?
      @user = User.where(:name => params[:name]).first
      @campaigns = Campaign.where("user_id = ?", @user.id)
      @complaints = CampaignComplaint.where("user_id = ?",  @user.id)
      @donations = Donation.where(:user_id =>  @user.id).order(:created_at)
    else 
      redirect_to root_path
    end
  end
end
