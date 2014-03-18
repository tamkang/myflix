require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
  	it "sets @queue_items for authenticated users" do
  	  wk = Fabricate(:user)
  	  session[:user_id] = wk.id
  	  queue_item1 = Fabricate(:queue_item, user: wk)
  	  queue_item2 = Fabricate(:queue_item, user: wk)
  	  get :index
  	  expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
  	end

  	it "redirects to login page for unauthenticated users" do
      wk = Fabricate(:user)
      queue_item1 = Fabricate(:queue_item, user: wk)
      queue_item2 = Fabricate(:queue_item, user: wk)
      get :index
      expect(response).to redirect_to login_path

    end
  end

  describe "POST create" do
    it "redirects to my queue" do
      wk = Fabricate(:user)
      session[:user_id] = wk.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "adds a video to my queue" do
      wk = Fabricate(:user)
      session[:user_id] = wk.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "adds a video associated with the video" do
      wk = Fabricate(:user)
      session[:user_id] = wk.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "adds a video that is associated with the user" do
      wk = Fabricate(:user)
      session[:user_id] = wk.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(wk)
    end
    it "puts the video as the last one in my queue" do
      wk = Fabricate(:user)
      session[:user_id] = wk.id
      video = Fabricate(:video)
      Fabricate(:queue_item, video: video, user: wk)
      video2 = Fabricate(:video)
      post :create, video_id: video2.id
      video2_queue_item = QueueItem.where(video_id: video2.id, user_id: wk.id).first
      expect(video2_queue_item.position).to eq("2")
    end
    it "does not create the video if the video is already in my queue" do
      wk = Fabricate(:user)
      session[:user_id] = wk.id
      video = Fabricate(:video)
      Fabricate(:queue_item, video: video, user: wk)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)

    end
    it "redirects to login page for unauthenticated user" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to login_path
    end
  end

  describe "DELETE destroy" do
    it "redirects to my queue page" do
      wk = Fabricate(:user)
      session[:user_id] = wk.id
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: wk, video: video)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end
    it "delete the video if that video is in the queue_item" do
      wk = Fabricate(:user)
      session[:user_id] = wk.id
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: wk, video: video)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end
    it "does not delete the video if that video is not in the queue_item" do
      wk = Fabricate(:user)
      session[:user_id] = wk.id
      wkz = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: wkz)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    it "redirects to login page for unauthenticated user" do
      delete :destroy, id: 1
      expect(response).to redirect_to login_path
    end
  end
end