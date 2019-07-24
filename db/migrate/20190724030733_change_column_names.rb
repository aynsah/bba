class ChangeColumnNames < ActiveRecord::Migration[5.2]
  def change
    rename_column :campaign_complaints, :category_id, :complaint_category_id
    rename_column :users, :subcribed, :subscribed
  end
end
