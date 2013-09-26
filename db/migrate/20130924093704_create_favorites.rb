class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.boolean :active, :default => false
      t.integer :user_id
      t.integer :vehicle_id

      t.timestamps
    end
  end
end
