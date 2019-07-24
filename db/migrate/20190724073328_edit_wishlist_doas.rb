class EditWishlistDoas < ActiveRecord::Migration[5.2]
  def change
    remove_column :wishlist_doas, :disturbance
    change_column :wishlist_doas, :doa_status_id, :integer, default: 1
    add_column :wishlist_doas, :user_id, :integer
  end
end
