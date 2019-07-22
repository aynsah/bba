class AddDefaultCheckedToComplaint < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :admin, :boolean, default: false
    change_column :campaign_complaints, :checked, :boolean, default: false
  end
end
