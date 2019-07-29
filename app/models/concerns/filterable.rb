module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(category_filter, user_filter, status_filter, search_filter)
      user_filter = user_filter == "Verified User" ? true : false if user_filter != "All"
      results = self.where(nil).joins(:user)
      results = results.category_id(category_filter) if category_filter.present? && category_filter != "All"
      results = results.users.verified_user(user_filter) if user_filter.present? && user_filter != "All"
      results = filter_of_status(results,status_filter) if status_filter.present? && status_filter != "All"
      results = results.where('campaign_title like ? or users.name like ? or donation_target = ?', "%#{search_filter}%", "%#{search_filter}%", search_filter.to_i ) if search_filter.present? && search_filter != ""

      results
    end

    def filter_of_status(results,status_filter)
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