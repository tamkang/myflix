class AppMailer < ActionMailer::Base 
  def welcome_email(user)
  	@user = user
  	mail from:  'wk@example.com', to: user.email, subject: "Welcome to Myflix!"
  end
end