class DropQueues < ActiveRecord::Migration
  def up
    drop_table :queues
  end

  def down
    drop_table :queues do |t|
      t.string :video_id, :user_id
      t.string :position

      t.timestamps        
    end
  end
end
