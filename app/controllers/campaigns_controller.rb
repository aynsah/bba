class CampaignsController < ApplicationController
  before_action :find_campaign, only: [:show, :edit, :update, :destroy]

  def index
    @campaigns = Campaign.paginate(page: params[:page], per_page: 6).filter(params[:category_filter], params[:user_filter], params[:status_filter], params[:search_filter], (params[:data1].to_s.gsub(/['Rp.','.']/,'').to_i), (params[:data2].to_s.gsub(/['Rp,','.']/,'').to_i)).order(created_at: :desc)
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
    if @campaign.save
      respond_to do |format|
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
    @donations = Donation.where(:campaign_id => params[:id])
  end

  def save_donation
    $donation.save
    @donations = Donation.where(:campaign_id => params[:id])
    respond_to do |format|
      format.js { render :action => "show" }
    end
  end

  def donate
    $donation = Donation.new(donation_params)
    donation_id = Donation.exists? ? Donation.last.id.to_i + 1 : 1

    response = Veritrans.create_widget_token(
      transaction_details: {
        order_id: "Donation-#{$donation.campaign_id}-#{donation_id}",
        gross_amount: $donation.donation_amount.to_i
      },
      customer_details: {
        first_name: current_user.name,
        email: current_user.email,
        phone: current_user.phone
      }
    )
    @snap_token = response.token

    respond_to do |format|
      format.js { render :js => "show_snap(#{$donation.campaign_id},\"" + "#{@snap_token}" + "\")"; }
    end
  end

  private
    def find_campaign
      if Campaign.exists?(params[:id])
        @campaign = Campaign.find(params[:id])
      end
    end

  private
    def donation_params
      params.require('/campaigns/' + params[:id]).permit(:donation_amount, :user_id, :campaign_id)
    end

    def campaign_params
      params.require(:campaign).permit(:image_campaign, :category_id, :campaign_title, :donation_target, :campaign_timeout, :campaign_desc, :additional_text, :user_id)
    end
end
