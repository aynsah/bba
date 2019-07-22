class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :campaign_complaints

  validates :donation_target, presence: true, length: { in: 6..10}

  def self.search(filter1)
    if filter1 != "1" && filter1
      # filter1 != "1" adalah filter "All"
      where('category_id like ?', "%#{filter1}%")
    else
      all
    end
  end
end
