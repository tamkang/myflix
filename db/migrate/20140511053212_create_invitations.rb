class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :inviter_id
      t.string :recipiant_name, :revipiant_email
      t.text :message
      t.timestamps
    end
  end
end
