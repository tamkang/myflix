class AddRecipiantEmailToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :recipiant_email, :string
  end
end
