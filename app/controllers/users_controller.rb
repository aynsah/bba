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

    def getting_started
      if current_user
        @user = User.find(current_user.id)
        redirect_to edit_registration_path(current_user) unless (@user.phone.nil? || @user.phone == "") && (@user.address.nil? || @user.address == "") && ( @user.bio.nil? || @user.bio = "")
        $username = @user.name if @user.provider.nil?
      else
        redirect_to new_user_session_path
      end
    end
end
