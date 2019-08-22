class CampaignsController < ApplicationController
  include CampaignsHelper
  before_action :find_campaign, only: [:show, :edit, :update, :destroy, :save_donation, :approval, :decline]
  protect_from_forgery with: :null_session, :only => [:receive_webhook]
  skip_before_action :verify_authenticity_token, :only => [:receive_webhook]

  def index
    @campaigns = Campaign.paginate(page: params[:page], per_page: 6)
                         .filter(
                            params[:category_filter], 
                            params[:user_filter], 
                            params[:status_filter], 
                            params[:search_filter], 
                            (params[:data1].to_s.gsub(/['Rp.','.']/,'').to_i), 
                            (params[:data2].to_s.gsub(/['Rp,','.']/,'').to_i)
                          )
                          .where(:status => "approved")
                          .order(created_at: :desc)
                          
    respond_to do |format|
      format.html
      format.js
    end
  end

  def receive_webhook
    post_body = request.body.read
    callback_params = Veritrans.decode_notification_json(post_body)

    verified_data = Veritrans.status(callback_params['transaction_id'])

    if verified_data.status_code != 404
      case verified_data.data[:transaction_status]
      when "capture"
        Campaign.notification_captured()
      when "settlement"
        Campaign.notification_completed(verified_data.data[:order_id])
      when "expired", "cancel"
        Campaign.notification_canceled(verified_data.data[:order_id])
      end

      render text: "ok"
    else
      render text: "ok", :status => :not_found
    end
  end

  def new
    redirect_to new_user_session_path unless current_user
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    
    respond_to do |format|
      if @campaign.save
        format.html {redirect_to( campaigns_path, 
                                  notice: 'Campaign telah berhasil dibuat. Silahkan tunggu admin untuk menyetujui'
                                )}
      else 
        @campaign.valid?
        format.html {redirect_to( new_campaign_path, 
                                  alert: @campaign.errors.full_messages[0]
                                )}
      end
    end
  end

  def edit
    only_user_and_admin @campaign
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to(campaigns_path, notice: 'Campaign Updated')
    else
      @campaign.valid?
      redirect_to(edit_campaign_path, alert: @campaign.errors.full_messages[0])
    end
  end

  def show
    @donations = Donation.where(:campaign_id => params[:id])
                         .where('donation_status = ? or donation_status = ?', 'completed', 'processed')

    @donation_needed = Campaign.calculate_donation(@campaign)
    only_user_and_admin @campaign unless @campaign.status == "approved"
  end

  def save_donation
    @donations = Donation.where(:campaign_id => params[:id], :donation_status => "completed")
    respond_to do |format|
      format.js { render :action => "show", notice: 'Donasi sedang di proses'}
    end
  end

  def donate
    donation_amount = params['/campaigns/' + params[:id]][:donation_amount] = 
    rounding_off_donation(
      params['/campaigns/' + params[:id]][:donation_amount],
      params['/campaigns/' + params[:id]][:campaign_id]
    )

    $donation = Donation.new(donation_params)
    $reportdonation = ReportDonation.new(donation_params)

    set_donation_keys
    payment_methods = set_payment_method donation_amount
    
    response = Veritrans.create_widget_token(
      transaction_details: {
        order_id: $donation.order_id,
        gross_amount: $donation.donation_amount.to_i
      },
      customer_details: {
        first_name: current_user.name,
        email: current_user.email,
        phone: current_user.phone
      },
      enabled_payments: payment_methods
    )
    @snap_token = response.token

    respond_to do |format|
      format.js { render :js => "show_snap(#{$donation.campaign_id},\"" + "#{@snap_token}" + "\")"; }
    end
  end

  def approval
    case params[:status_data]
    when "approve"
      @campaign.update_attribute("status", "approved")
      @emails = User.where("subscribed = true").pluck(:email)
      NewsletterMailer.with(email: @emails, campaign: @campaign).send_mail.deliver_now
      @campaignstarter = User.where("subscribed = true").pluck(:email)
        NewsletterMailer.with(email: @campaignstarter, campaign: @campaign).approved_mail.deliver_now
    when "decline"
      @campaign.update_attribute("status", "declined")
    when "block"
      @campaign.update_attribute("status", "blocked")
    end
  end

  def refund
    only_admin
  end

  private
    def find_campaign
      if Campaign.exists?(params[:id])
        @campaign = Campaign.find(params[:id])
      else
        redirect_to(campaigns_path, alert: "Campaign doesn't exists")
      end
    end

    def donation_params
      params.require('/campaigns/' + params[:id]).permit(:donation_amount, :user_id, :campaign_id)
    end

    def campaign_params
      params.require(:campaign).permit(:image_campaign, :category_id, :campaign_title, :donation_target, :campaign_timeout, :campaign_desc, :additional_text, :user_id)
    end

    def set_donation_keys
      $reportdonation.id = $donation.id = Donation.any? ? Donation.last.id + 1 : 1
      $reportdonation.created_at = $donation.created_at = Date.today.to_s(:number)

      $reportdonation.order_id = $donation.order_id = 
      "Donation-#{$donation.campaign_id}-#{$donation.id}_#{$donation.created_at.to_s(:number)}"
      
    end

end
