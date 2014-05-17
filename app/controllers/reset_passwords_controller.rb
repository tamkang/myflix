class ResetPasswordsController < ApplicationController
  def show
  	user = User.where(token: params[:id]).first
  	@user = user
  	if user
  	  @token = user.token
  	else
      redirect_to expired_token_path
    end
  end

  def create
  	user = User.where(token: params[:token]).first
  	if user
	  user.password = params[:password]
	  user.generate_token
	  user.save
	  flash[:success] = "Password reset successed! Now please login!"
	  redirect_to login_path
  	else
      redirect_to expired_token_path
  	end
  end

  def invalid
  end
end