class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :quantity
      t.float :price
      t.integer :supplier_id

      t.timestamps
    end
  end
end
