class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
  	change_column :report_products, :supplier_id, :integer
  end
end
