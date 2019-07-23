class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :campaign_complaints

  validates :donation_target, presence: true, length: { in: 6..10}

  def self.search(filter1, filter2)
    if filter1 != "All" && filter2 == "All"
      where('category_id like ?', "%#{filter1}%").joins(:user)
    elsif filter1 != "All" && filter2 == "Public User"
      where('category_id like ? and users.verified_user = ?', "%#{filter1}%", "false").joins(:user)
    elsif filter1 != "All" && filter2 == "Verified User"
      where('category_id like ? and users.verified_user = ?', "%#{filter1}%", "true").joins(:user)
    else
      all
    end
  end
end
