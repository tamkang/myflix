class SessionsController < ApplicationController
  def new
    @user = User.new
    redirect_to home_path if current_user
  end

  def create
    @user = User.where(email: params[:user][:email]).first
    if @user && @user.authenticate(params[:user][:password])
      flash[:success] = 'You are now logged in.'
      session[:user_id] = @user.id
      redirect_to home_path
    else
      flash[:error] = "Your login did not authenticate."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You're logged out!"
    redirect_to root_path
  end
end