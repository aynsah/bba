class ComplaintCategory < ApplicationRecord
  has_many :campaign_complaints, :autosave => true
end
