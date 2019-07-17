class AddProfilToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, default: "Anonym"
    add_column :users, :phone, :string
    add_column :users, :photo, :string
    add_column :users, :address, :text
    add_column :users, :bio, :text
  end
end
