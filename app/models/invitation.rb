class Invitation < ActiveRecord::Base
  belongs_to :inviter, class_name: "User"
  validates_presence_of :recipiant_email, :recipiant_name, :message
end