require 'spec_helper'
  describe VideosController do

  	describe "GET show" do
	    it "sets @video for authenticated users" do
	    	session[:user_id] = Fabricate(:user).id
 	      video = Fabricate(:video)
  	    get :show, id: video.id
  	    expect(assigns(:video)).to eq(video)
      end

  	  it "redirects to the sign in page for unauthticated users" do
        video = Fabricate(:video)
	      get :show, id: video.id
	      expect(response).to redirect_to login_path
  	  end

      it "sets the @review for authenticated users" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)
        get :show, id: video.id
        expect(assigns(:review)).to match_array([review1,review2])
      end
  	end

  	describe "POST search" do
  	  it "sets @videos for authenticated users" do
	  	session[:user_id] = Fabricate(:user).id
 	    avatar = Fabricate(:video, title: "avatar")
  	    post :search, search_term: "tar"
  	    expect(assigns(:videos)).to eq([avatar])
  	  end

  	  it "redirects to the sign in page for unauthticated users" do
 	    avatar = Fabricate(:video, title: "avatar")
  	    post :search, search_term: "tar"
  	    expect(response).to redirect_to login_path
  	  end
  	end
  end