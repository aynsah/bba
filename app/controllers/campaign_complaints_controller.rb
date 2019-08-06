class CampaignComplaintsController < ApplicationController
  def new
    @campaign_complaint = CampaignComplaint.new
  end

  def create
    user = current_user.id
    @campaign_complaint = CampaignComplaint.new(campaign_complaint_params)
    @campaign_complaint.user_id = user
    if @campaign_complaint.save
      redirect_to(campaigns_path, notice: 'Complaint has been sent')
    else
      @ca
      redirect_to(new_campaign_complaint_path, error: @campaign_complaint.errors.full_messages[0])
    end
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
      params[:campaign_complaint].permit(:complaint_category_id, :complaint, :campaign_id)
    end
end
