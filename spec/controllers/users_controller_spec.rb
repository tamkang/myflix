require 'spec_helper'
  describe UsersController do
  	describe "GET new" do
  	  it "sets @user" do
  	  get :new 
  	  expect(assigns(:user)).to be_instance_of(User)
  	  end
  	end

    describe "GET show" do
      it_behaves_like "require sign in" do
        let(:action) { get :show, id: 3}
      end

      it "sets @user" do
        set_current_user
        wk = Fabricate(:user)
        get :show, id: wk.id
        expect(assigns(:user)).to eq(wk)
      end

      it "sets @queue_item" do
        set_current_user
        wk = Fabricate(:user)
        get :show, id: wk.id
        expect(assigns(:queue_item)).to eq(wk.queue_items)
      end

      it "sets @review" do
        set_current_user
        wk = Fabricate(:user)
        get :show, id: wk.id
        expect(assigns(:review)).to eq(wk.reviews)
      end
    end

  	describe "POST create" do
      context "with valid input" do
      	it "create users" do
      	  post :create, user: { email: "wk@example", fullname: "wk", password: "password"}
      	  expect(User.count).to eq(1)
      	end
      	it "sets the user in the seesion" do
      	  post :create, user: { email: "wk@example", fullname: "wk", password: "password"}
      	  expect(session[:user_id]).to eq(User.first.id)
      	end
      	it "redirects home_path " do
      	  post :create, user: { email: "wk@example", fullname: "wk", password: "password"}
      	  expect(response).to redirect_to home_path
      	end
      end
      context "with invalid input" do
        it "shouldn't create the user" do
      	  post :create, user: { fullname: "wk", password: "password"}
      	  expect(User.count).to eq(0)
        end
        it "renders users#new " do
      	  post :create, user: { fullname: "wk", password: "password"}
      	  expect(response).to render_template :new
        end
        it "sets the @user" do
      	  post :create, user: { fullname: "wk", password: "password"}
      	  expect(assigns(:user)).to be_instance_of(User)
        end
      end
  	end

    describe "GET new_with_invitation_token" do
      it "renders new template" do
        invitation = Fabricate(:invitation, token: "12345")
        get :new_with_invitation_token, token: "12345"
        expect(response).to render_template :new
      end

      it "sets @user with recipiant email" do
        wk = Fabricate(:user)
        invitation = Fabricate(:invitation, recipiant_email: wk.email, token: "12345")
        get :new_with_invitation_token, token: "12345"
        expect(assigns(:user).email).to eq(invitation.recipiant_email)
      end

      it "redirects_to expired token path for invalid token" do
        wk = Fabricate(:user)
        invitation = Fabricate(:invitation, recipiant_email: wk.email, token: "12345")
        get :new_with_invitation_token, token: "1234"
        expect(response).to redirect_to expired_token_path
      end
    end
  end