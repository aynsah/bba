class Campaign < ApplicationRecord
  include Filterable
  include Notification
  belongs_to :user
  belongs_to :category
  has_many :donations
  has_many :campaign_complaints, dependent: :destroy

  mount_uploader :image_campaign, AvatarUploader
  validates :campaign_title, length: { maximum: 75 , message: "letters maximum only 75"}
  validates :donation_target, numericality: { only_integer: true, message: "number only" }
  validates :image_campaign, presence: {message: "must exist"}
  validates :donation_target, presence: true, length: { in: 4..10, message: "only 4 - 10 digits"}
  validate :valid_date

  def valid_date
    if campaign_timeout.present? && campaign_timeout < Date.today
      errors.add(:campaign_timeout, "can't be in the past")
    end
  end


  def self.date_after(campaign_timeout)
    changed_timeout = ""
    timeout = (campaign_timeout - Date.today).to_i
    if timeout < 1
      changed_timeout = "Selesai"
    elsif timeout == 0
      changed_timeout = "< 1 Hari"
    else
      if (timeout.days)/1.year != 0
        total_year = (timeout.days)/1.year
        timeout %= total_year
      end
      if (timeout.days)/1.months != 0
        total_months = (timeout.days)/1.months
        timeout %= total_months
      end
      total_days = timeout

      changed_timeout += total_year.to_s + " tahun " if total_year != nil
      changed_timeout += total_months.to_s + " bulan " if total_months != nil
      changed_timeout += total_days.to_s + " hari " if total_days != 0
    end
    return changed_timeout
  end

  RailsAdmin.config do |config|
    config.total_columns_width = 1000
    config.model Campaign do

      list do
        field :id
        field :campaign_title 
        field :category
        field :donation_target
        field :user
      end

    end
  end

end
