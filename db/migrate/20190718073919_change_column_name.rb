class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :report_products, :supplier, :supplier_id
  end
end
