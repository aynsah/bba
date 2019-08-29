  module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(category_filter, user_filter, status_filter, search_filter, donation_filter1, donation_filter2)
      donation_filter1 = 0 if donation_filter1.to_i < 0
      donation_filter2 = 1000000000 if donation_filter2.to_i > 1000000000 || donation_filter2.to_i == 0

      results = self.where(nil)
      results = results.where(:category_id => category_filter) if category_filter.present? && category_filter != "Semua"
      results = filtering_users(results,user_filter) if user_filter.present?
      results = filtering_status(results,status_filter) if status_filter.present?
      results = results.where(donation_target: donation_filter1..donation_filter2) if donation_filter1.present? && donation_filter2.present?
      results = results.where('campaign_title like ? or users.name like ?', "%#{search_filter}%", "%#{search_filter}%") if search_filter.present? && search_filter != ""

      results
    end

    def filtering_users(results,user_filter)
      results = results.joins(:user)
      if user_filter == "Verified User"
        return results.where('users.verified_user = true')
      elsif user_filter == "Public User"
        return results.where('users.verified_user = false')
      else
        return results
      end
    end

    def filtering_status(results,status_filter)
      if status_filter == "Sedang Berjalan"
        return results.where("campaign_timeout > ?", Date.today)
      elsif status_filter == "Belum Tercapai"
        campaigns = Array.new
        results.each do |result|
          campaign_donation = Donation.where(:campaign_id => result.id, :donation_status => 'completed').sum('donation_amount')
          campaigns << result if result.donation_target > campaign_donation
        end
        return results.where(id: campaigns.map(&:id))
      elsif status_filter == "Telah Selesai"
        return results.where("campaign_timeout < ?", Date.today)
      else
        return results
      end
    end
    
  end
end