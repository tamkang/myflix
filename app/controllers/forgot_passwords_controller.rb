class ForgotPasswordsController < ApplicationController
  def create
    user = User.where(email: params[:email]).first
    if user
      redirect_to forgot_password_confirmation_path
      AppMailer.reset_password(user).deliver
    else
      redirect_to new_forgot_password_path
      flash[:error] = "something wrong!please try again!"
    end
  end

  def confirm  	
  end
end