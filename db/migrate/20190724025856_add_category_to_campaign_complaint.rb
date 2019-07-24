class AddCategoryToCampaignComplaint < ActiveRecord::Migration[5.2]
  def change
    add_column :campaign_complaints, :category_id, :integer
  end
end
