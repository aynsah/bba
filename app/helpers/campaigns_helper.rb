module CampaignsHelper
  def current_donation(campaign)
    ( campaign.donations.sum(:donation_amount) /  campaign.donation_target ) * 100 
  end

  def rounding_off_donation(donation_amount)
    donation_amount = 1000 if donation_amount.to_i < 1000
    (donation_amount.to_i / 1000 ).ceil * 1000
  end

  def set_payment_method(donation_amount)
    if donation_amount.to_i >= 10000
      payment = ["credit_card", "mandiri_clickpay", "cimb_clicks", "bca_klikbca", "bca_klikpay", "bri_epay", "echannel", "mandiri_ecash",
                "permata_va", "bca_va", "bni_va", "other_va", "gopay", "indomaret","danamon_online", "akulaku"]
      payment
    else
      payment = ["gopay", "akulaku"] 
      payment
    end
  end
end
