class CreateReportDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :report_donations do |t|
      t.integer :donation_amount
      t.integer :user_id
      t.integer :campaign_id
      t.string :donation_status
      t.timestamps
      t.string :order_id

    end
  end
end
