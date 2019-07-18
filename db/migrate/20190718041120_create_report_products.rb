class CreateReportProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :report_products do |t|
      t.string :name
      t.integer :quantity
      t.float :price
      t.string :supplier

      t.timestamps
    end
  end
end
