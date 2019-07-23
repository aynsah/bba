class CampaignsController < ApplicationController
  before_action :find_campaign, only: [:show, :edit, :update, :destroy]

  def index
    @campaigns = Campaign.search(params[:category_filter],params[:user_filter])
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.save
    redirect_to campaigns_path
  end

  def edit
  end

  def update
    @current_user = current_user.id
    @campaign.update(campaign_params)
    redirect_to campaigns_path
    
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  private
    def find_campaign
      @campaign = Campaign.find(params[:id])
    end

  private
    def campaign_params
      params.require(:campaign).permit(:image_campaign, :category_id, :campaign_title, :donation_target, :campaign_timeout, :campaign_desc, :additional_text, :user_id)
    end
end
