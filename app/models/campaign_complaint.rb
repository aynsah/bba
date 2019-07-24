class CampaignComplaint < ApplicationRecord
  belongs_to :user
  belongs_to :campaign
  belongs_to :complaint_category
end