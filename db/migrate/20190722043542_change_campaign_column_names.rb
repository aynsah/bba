class ChangeCampaignColumnNames < ActiveRecord::Migration[5.2]
  def change
    rename_column :campaigns, :campaign_category, :category_id
  end
end
