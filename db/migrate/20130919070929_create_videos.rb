class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.attachment :video
      t.attachment :avatar
      t.integer    :user_id
      t.integer    :vehicle_id

      t.timestamps
    end
  end
end
