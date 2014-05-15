class RemoveRevipiantEmailFromInvitations < ActiveRecord::Migration
  def change
  	remove_column :invitations, :revipiant_email, :string
  end
end
