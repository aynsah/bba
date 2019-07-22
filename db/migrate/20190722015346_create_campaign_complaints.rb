class CreateCampaignComplaints < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_complaints do |t|
      t.boolean :checked
      t.string :user_id
      t.text :complaint
      t.string :campaign_id

      t.timestamps
    end
  end
end
