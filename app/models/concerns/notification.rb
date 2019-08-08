module Notification
  extend ActiveSupport::Concern

  module ClassMethods
    def notification_canceled(order_id) 
      find_donation(order_id).update(:donation_status => "canceled")
    end
    
    def notification_captured() 
      $donation.donation_status = "processed"
      $donation.save
    end

    def notification_completed(order_id) 
      find_donation(order_id).update(:donation_status => "completed")
    end

    def find_donation(order_id)
      donation_id = order_id.slice(-(order_id.reverse.index('-'))...order_id.index('_'))
      donation = Donation.find(donation_id)
      return donation
    end
  end
end