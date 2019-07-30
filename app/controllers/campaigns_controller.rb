class CampaignsController < ApplicationController
  before_action :find_campaign, only: [:show, :edit, :update, :destroy]

  def index
    @campaigns = Campaign.paginate(page: params[:page], per_page: 6).filter(params[:category_filter], params[:user_filter], params[:status_filter], params[:search_filter], params[:data1], params[:data2]).order(created_at: :desc)
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)

    respond_to do |format|
      if @campaign.save
        @emails = User.where("subscribed = true").pluck(:email)
        NewsletterMailer.with(email: @emails, campaign: @campaign).send_mail.deliver_now
        format.html { redirect_to(campaigns_path, notice: 'Campaign was successfully created')}
      end
    end
  end

  def edit
  end

  def update
    @campaign.update(campaign_params)
    redirect_to campaigns_path
    
  end

  def show
  end

  private
    def find_campaign
      if Campaign.exists?(params[:id])
        @campaign = Campaign.find(params[:id])
      end
    end

  private
    def campaign_params
      params.require(:campaign).permit(:image_campaign, :category_id, :campaign_title, :donation_target, :campaign_timeout, :campaign_desc, :additional_text, :user_id)
    end
end
