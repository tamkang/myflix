class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @queue_item = @user.queue_items
    @review = @user.reviews
  end

  def create
    @user = User.new(user_params)

    if @user.save
      AppMailer.welcome_email(@user).deliver
      flash[:success] = "Your account has been created!"
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render :new
    end
  end

  def new_with_invitation_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipiant_email)
      render :new
    else
      redirect_to expired_token_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :email, :fullname)
  end
end
