class InvitationsController < ApplicationController
  before_filter :require_user
  def new
  	@invitation = Invitation.new
  end

  def create
  	@invitation = Invitation.create(invitation_params.merge!(inviter_id: current_user.id))
  	if @invitation.save
	  AppMailer.delay.send_invitation(@invitation)
	  flash[:success] = "Your invitation email has been sent!"
	  redirect_to new_invitation_path
	else
	  flash[:error] = "Something wrong! Please try again!"
	  render :new
	end
  end

  private
  
  def invitation_params
  	params.require(:invitation).permit(:recipiant_name, :recipiant_email, :message)
  end
end