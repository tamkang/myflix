require 'spec_helper'
  describe UsersController do
  	describe "GET new" do
  	  it "sets @user" do
  	  get :new 
  	  expect(assigns(:user)).to be_instance_of(User)
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
      context "with invalid input"
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