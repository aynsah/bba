class AddDateToWishlistDoas < ActiveRecord::Migration[5.2]
  def change
    add_column :wishlist_doas, :expired_at, :date
  end
end
