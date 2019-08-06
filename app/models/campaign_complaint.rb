class CampaignComplaint < ApplicationRecord
  belongs_to :user
  belongs_to :campaign
  belongs_to :complaint_category

  validates :campaign_id, presence: {message: 'Please try again later'}
  validates :complaint, presence: {message: "can't be blank"}
end