class Campaign < ApplicationRecord
  belongs_to :user

  def self.search(query)
    if query && query != "All"
      where('campaign_category like ?', "%#{query}%")
    else
      all
    end
  end
end
