class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :donation_target, presence: true, length: { in: 6..10}

  def self.search(filter1, filter2)
    if filter1 != "All"
      where('category_id like ?', "%#{filter1}%")
    else
      all
    end
  end
end
