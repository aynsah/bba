class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :campaign_title, null: false
      t.string :campaign_category
      t.integer :donation_target
      t.date :campaign_timeout
      t.text :campaign_desc
      t.text :additional_text
      t.string :image_campaign
      t.string :user_id


      t.timestamps
    end
  end
end
