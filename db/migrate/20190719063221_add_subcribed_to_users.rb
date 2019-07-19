class AddSubcribedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :subcribed, :boolean, default: false
    change_column :users, :verified_user, :boolean, default: false
  end
end
