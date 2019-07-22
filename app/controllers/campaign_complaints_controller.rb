class CampaignComplaintsController < ApplicationController
  def new
    @complaint = CampaignComplaint.new
  end

  def create
    user = current_user.id
    @complaint = CampaignComplaint.new(complaint_params)
    @complaint.user_id = user
    @complaint.validate!
    @complaint.save
    redirect_to root_path
  end

  private
    def complaint_params
      params.permit(:complaint, :campaign_id)
    end
end
