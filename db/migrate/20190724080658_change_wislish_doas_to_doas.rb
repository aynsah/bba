class ChangeWislishDoasToDoas < ActiveRecord::Migration[5.2]
  def change
    rename_table :wishlist_doas, :doas
  end
end
