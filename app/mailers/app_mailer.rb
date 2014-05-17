class AppMailer < ActionMailer::Base 
  def welcome_email(user)
  	@user = user
  	mail from:  'wk@example.com', to: user.email, subject: "Welcome to Myflix!"
  end

  def reset_password(user)
  	@user = user
  	mail from: 'wk@example.com', to: user.email, subject: "Reset Your Password in MyFlix!"
  end

  def send_invitation(invitation)
    @invitation = invitation
  	mail from: 'wk@example.com', to: invitation.recipiant_email, subject: "Please join us in MyFlix!"
  end
end