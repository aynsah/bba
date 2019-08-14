class ChangeColumnApproved < ActiveRecord::Migration[5.2]
  def change
    rename_column :campaigns, :approved, :status
    change_column :campaigns, :status, :string, default: "unchecked"
  end
end
