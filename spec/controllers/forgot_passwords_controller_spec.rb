require 'spec_helper'
describe ForgotPasswordsController do
  describe "POST create" do
	context "with invalid input" do
	  it "redirects to forgot password path" do
	  	post :create, email: "www"
	  	expect(response).to redirect_to new_forgot_password_path
	  end
	  
	  it "flashes error" do
	  	post :create, email: "www"
	  	expect(flash[:error]).to be_present
	  end
	end
	
	context "with valid input" do
	  it "redirects to confirm page" do
	  	wk = Fabricate(:user, email: "wk@example.com")
	  	post :create, email: wk.email
	  	expect(response).to redirect_to forgot_password_confirmation_path
	  end
	  it "sends passwords reset email" do
	  	wk = Fabricate(:user, email: "wk@example.com")
	  	post :create, email: wk.email
	  	expect(ActionMailer::Base.deliveries.last.to).to eq([wk.email])
	  end
	end
  end
end