class CreateQueues < ActiveRecord::Migration
  def change
    create_table :queues do |t|
    	t.integer :position
    	t.integer :user_id, :video_id

    	t.timestamps
    end
  end
end
