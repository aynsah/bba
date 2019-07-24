class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
  	change_column :campaigns, :user_id, 'integer USING CAST(user_id AS integer)'
  	change_column :campaign_complaints, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end
