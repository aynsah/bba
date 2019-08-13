class AddOrderIdToDonation < ActiveRecord::Migration[5.2]
  def change
    add_column :donations, :order_id, :string, null: false
  end
end
