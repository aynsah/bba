class CampaignComplaintsController < ApplicationController
  def new
    redirect_to new_user_session_path unless current_user
    @campaign_complaint = CampaignComplaint.new
  end

  def create
    @campaign_complaint = CampaignComplaint.new(campaign_complaint_params)
    @campaign_complaint.user_id = current_user.id
    if @campaign_complaint.save
      redirect_to(campaigns_path, notice: 'Complaint has been sent')
    else
      @campaign_complaint.valid?
      redirect_to("/campaign_complaints/new?campaign_id=#{@campaign_complaint.campaign_id}", alert: @campaign_complaint.errors.full_messages[0])
    end
  end

  def show
    @complaint = CampaignComplaint.find(params[:id])
    @campaign = Campaign.find(@complaint.campaign_id)
    only_user_and_admin(@complaint)
  end

  def show_all
    @campaign = Campaign.find(params[:id])
    @complaints = CampaignComplaint.where("campaign_id = ?", "#{@campaign.id}")
    only_admin
  end

  private
    def campaign_complaint_params
      params[:campaign_complaint].permit(:complaint_category_id, :complaint, :campaign_id)
    end
end
