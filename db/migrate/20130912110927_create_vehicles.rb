class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string   :title
      t.string   :price
      t.integer  :category_id
      t.string   :condition
      t.string   :location
      t.string   :type
      t.string   :note
      t.text     :description
      t.string   :vin
      t.attachment :avatar
      t.boolean  :active
      t.string   :status

      t.timestamps
    end
  end
end
