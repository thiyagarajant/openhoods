class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :note
      t.text :description
      t.datetime :s_date
      t.datetime :e_date
      t.string :location
      t.attachment :avatar

      t.timestamps
    end
  end
end
