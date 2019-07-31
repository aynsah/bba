module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(category_filter, user_filter, status_filter, search_filter, donation_filter1, donation_filter2)
      donation_filter1 = 0 if donation_filter1.to_i < 0
      donation_filter2 = 1000000000 if donation_filter2.to_i > 1000000000 || donation_filter2.to_i == 0
      results = self.where(nil).joins(:user)
      results = results.category_id(category_filter) if category_filter.present? && category_filter != "All"
      results = filtering_users(results,user_filter) if user_filter.present?
      results = filtering_status(results,status_filter) if status_filter.present?
      results = results.where(donation_target: donation_filter1...donation_filter2) if donation_filter1.present? && donation_filter2.present?
      results = results.where('campaign_title like ? or users.name like ?', "%#{search_filter}%", "%#{search_filter}%") if search_filter.present? && search_filter != ""

      results
    end

    def filtering_users(results,user_filter)
      if user_filter == "Verified User"
        return results.users.verified_user(true)
      elsif user_filter == "Public User"
        return results.users.verified_user(false)
      else
        return results
      end
    end

    def filtering_status(results,status_filter)
      if status_filter == "On Progress"
        return results.where("campaign_timeout > ?", Date.today)
      elsif status_filter == "Unachieved"
        return results.where(nil)
      elsif status_filter == "Finished"
        return results.where("campaign_timeout < ?", Date.today)
      else
        return results
      end
    end
    
  end
end