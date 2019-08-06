class Campaign < ApplicationRecord
  include Filterable
  include Notification
  belongs_to :user
  belongs_to :category
  has_many :donations
  has_many :campaign_complaints, dependent: :destroy

  validates :donation_target, presence: true, length: { in: 4..10}

  mount_uploader :image_campaign, AvatarUploader

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


end
