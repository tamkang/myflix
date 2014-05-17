require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
  	it "sets @invitation to a new invitation" do
  	  wk = Fabricate(:user)
  	  set_current_user(wk)
  	  get :new
  	  expect(assigns(:invitation)).to be_new_record
  	  expect(assigns(:invitation)).to be_instance_of Invitation
  	end

  	it_behaves_like "require sign in" do
  	  let(:action) { get :new }
  	end
  end

  describe "POST create" do
  	it_behaves_like "require sign in" do
      let(:action) { post :create }
  	end
  	context "with valid input" do
	    it "redirect to invitation#new" do
  	  	wk = Fabricate(:user)
  	  	set_current_user(wk)
  	  	post :create, invitation: { recipiant_name: "wk zhang", recipiant_email: "wkz@example.com", message: "message"}
  	  	expect(response).to redirect_to new_invitation_path
	    end
  	  it "create an invitation" do
  	  	wk = Fabricate(:user)
  	  	set_current_user(wk)
  	  	post :create, invitation: { recipiant_name: "wk zhang", recipiant_email: "wkz@example.com", message: "message"}
  	  	expect(Invitation.count).to eq(1)
  	  end
	  it "send out invitation email" do
	  	wk = Fabricate(:user)
  	  	set_current_user(wk)
  	  	post :create, invitation: { recipiant_name: "wk zhang", recipiant_email: "wkz@example.com", message: "message"}
  	  	expect(ActionMailer::Base.deliveries.last.to).to eq(["wkz@example.com"])
	    end
	  it "flashes success message" do
	    wk = Fabricate(:user)
  	  	set_current_user(wk)
  	  	post :create, invitation: { recipiant_name: "wk zhang", recipiant_email: "wkz@example.com", message: "message"}
  	  	expect(flash[:success]).to be_present
	    end
	  end
	  context "with invalid input" do
	    it "redirect to renders invitation#new" do
	      wk = Fabricate(:user)
    	  set_current_user(wk)
  	    post :create, invitation: { recipiant_email: "wkz@example.com", message: "message"}
  	    expect(response).to render_template :new
	    end
	    it "flashes error" do
	      wk = Fabricate(:user)
  	    set_current_user(wk)
  	    post :create, invitation: { recipiant_email: "wkz@example.com", message: "message"}
  	    expect(flash[:error]).to be_present
	    end
	    it "sets @invitation" do
	      wk = Fabricate(:user)
  	    set_current_user(wk)
  	    post :create, invitation: { recipiant_email: "wkz@example.com", message: "message"}
  	    expect(assigns(:invitation)).to be_present
	    end
	  end
  end
end