class CreateQueueItems < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.string :user_id, :video_id
      t.string :position

      t.timestamps
    end
  end
end
