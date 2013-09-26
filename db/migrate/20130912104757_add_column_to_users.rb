class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :integer
    add_column :users, :role_id, :integer
    add_column :users, :status, :boolean, :default => false
    add_attachment :users, :avatar
    add_attachment :users, :cover_photo
  end
end
