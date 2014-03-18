require 'spec_helper'

describe ReviewsController do 
  describe "POST create" do
  	context "with authenticated users" do
	  context "with valid input" do
	    it "redirects to the video show page" do
	      session[:user_id] = Fabricate(:user).id
	      video = Fabricate(:video)
	      post :create, review: Fabricate.attributes_for(:review), video_id: video.id
	      expect(response).to redirect_to video
	    end
	    it "create a review" do
	      session[:user_id] = Fabricate(:user).id
	      video = Fabricate(:video)
	      post :create, review: Fabricate.attributes_for(:review), video_id: video.id
	      expect(Review.count).to eq(1)
	    end
	    it "create a review associated with the video" do
	      session[:user_id] = Fabricate(:user).id
	      video1 = Fabricate(:video)
	      post :create, review: Fabricate.attributes_for(:review), video_id: video1.id
	      expect(Review.first.video).to eq(video1)
	    end
	    it "create a review associated with the signed in user" do
	      wk = Fabricate(:user)
	      session[:user_id] = wk.id
	      video1 = Fabricate(:video)
	      post :create, review: Fabricate.attributes_for(:review), video_id: video1.id
	      expect(Review.first.user_id).to eq(session[:user_id])
	    end
	  end
	  context "with invalid input" do
	  	it "does not create a review" do
	      session[:user_id] = Fabricate(:user).id
	      video1 = Fabricate(:video)
	      post :create, review: { rating: 5 }, video_id: video1.id
	      expect(Review.count).to eq(0)
	  	end
	  	it "render video show page" do
	  	  session[:user_id] = Fabricate(:user).id
	      video1 = Fabricate(:video)
	      post :create, review: { rating: 5 }, video_id: video1.id
	      expect(response).to render_template "videos/show"
	  	end

	  	it "sets @video" do
	      session[:user_id] = Fabricate(:user).id
	      video1 = Fabricate(:video)
	      post :create, review: { rating: 5 }, video_id: video1.id
	      expect(assigns(:video)).to eq(video1)	  	  
	  	end
	  	it "sets @review" do
	      session[:user_id] = Fabricate(:user).id
	      video1 = Fabricate(:video)
	      review1 = Fabricate(:review, video: video1)
	      post :create, review: { rating: 5 }, video_id: video1.id
	      expect(assigns(:review)).to match_array([review1])
	  	end
	  	it "flash error" do
	  	  session[:user_id] = Fabricate(:user).id
	      video1 = Fabricate(:video)
	      review1 = Fabricate(:review, video: video1)
	      post :create, review: { rating: 5 }, video_id: video1.id
	      expect(flash[:error]).to be_present
	  	end
	  end
	end

	context "with unauthenticated users" do
	  it "redirects to sign in page" do
	  	  video1 = Fabricate(:video)
	      post :create, review: { rating: 5 }, video_id: video1.id
	      expect(response).to redirect_to login_path	  	  
	  end
	end

  end
end
