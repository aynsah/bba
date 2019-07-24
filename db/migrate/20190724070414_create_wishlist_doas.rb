class CreateWishlistDoas < ActiveRecord::Migration[5.2]
  def change
    create_table :wishlist_doas do |t|
      t.string :title
      t.text :doa
      t.text :doa_desc
      t.integer :doa_status_id
      t.text :disturbance

      t.timestamps
    end
  end
end
