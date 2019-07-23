class CampaignComplaintsController < ApplicationController
  def new
    @campaign_complaint = CampaignComplaint.new
  end

  def create
    user = current_user.id
    @campaign_complaint = CampaignComplaint.new(campaign_complaint_params)
    @campaign_complaint.user_id = user
    @campaign_complaint.validate!
    @campaign_complaint.save
    redirect_to root_path
  end

  def show
    @complaint = CampaignComplaint.find(params[:id])
    @campaign = Campaign.find(@complaint.campaign_id)
  end

  def show_all
    @campaign = Campaign.find(params[:id])
    @complaints = CampaignComplaint.where("campaign_id = ?", "#{@campaign.id}")
    
  end

  private
    def campaign_complaint_params
      params[:campaign_complaint].permit(:complaint, :campaign_id)
    end
end
