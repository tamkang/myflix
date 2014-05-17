require 'spec_helper'

describe ResetPasswordsController do
  describe "GET show" do
  	it "renders to show template with valid token" do
  	  wk = Fabricate(:user)
  	  wk.update_column(:token, "12345")
  	  get :show, id: "12345"
  	  expect(response).to render_template :show
  	end
    it "sets @token to verify user's identity" do
      wk = Fabricate(:user)
      wk.update_column(:token, "12345")
      post :show, id: "12345"
      expect(assigns(:token)).to eq(wk.token)
    end   
  	it "redirects to expired token page if invalid token" do
  	  wk = Fabricate(:user, token: "12345")
  	  get :show, id: "123"
  	  expect(response).to redirect_to expired_token_path
  	end
  end

  describe "POST create" do
    context "with valid token" do
      it "redirects to login page" do
        wk = Fabricate(:user, password: "old_password")
        wk.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(response).to redirect_to login_path
      end
    	it "reset passwords" do
        wk = Fabricate(:user, password: "new_password")
        wk.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(wk.reload.password).to eq("new_password")
      end
      it "flashes success message" do
        wk = Fabricate(:user, password: "old_password")
        wk.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(flash[:success]).to be_present
      end

      it "regenerate token" do
        wk = Fabricate(:user, password: "old_password")
        wk.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(wk.reload.token).not_to eq("12345")
      end
    end

    context "with invalid token" do
      it "redirect_to expired_token_path" do
        wk = Fabricate(:user, password: "old_password")
        wk.update_column(:token, "12345")
        post :create, token: "1234", password: "new_password"
        expect(response).to redirect_to expired_token_path
      end
    end

  end
end