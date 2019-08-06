class AddCampaignCondition < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :approved, :boolean, default: false
  end
end
