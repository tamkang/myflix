require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do
  	it "sets @relationships for the follower" do
	  wkz = Fabricate(:user)
	  set_current_user(wkz)
	  wkm = Fabricate(:user)
	  relationship = Fabricate(:relationship, follower_id: wkz.id, leader_id: wkm.id)
	  get :index
	  expect(assigns(:relationships)).to eq([relationship])
    end

    it_behaves_like "require sign in" do
      let(:action) { get :index }
    end
  end

  describe "POST create" do
    it_behaves_like "require sign in" do
      let(:action) { post :create }
    end
    
    it "redirects to people page " do
      wkz = Fabricate(:user)
      set_current_user(wkz)
      wkm = Fabricate(:user)
      post :create, leader_id: wkm.id
      expect(response).to redirect_to people_path
    end

    it "creates relationship between currnet user and leader" do
      wkz = Fabricate(:user)
      set_current_user(wkz)
      wkm = Fabricate(:user)
      post :create, leader_id: wkm.id
      expect(wkz.following_relationships.first.leader).to eq(wkm)
    end

    it "does not create relationship if current user is already follow leader" do
      wkz = Fabricate(:user)
      set_current_user(wkz)
      wkm = Fabricate(:user)
      relationship = Fabricate(:relationship, leader_id: wkm.id, follower_id: wkz.id)
      post :create, leader_id: wkm.id
      expect(Relationship.count).to eq(1)
    end

    it "does not create relationship if current user is leader" do
      wkz = Fabricate(:user)
      set_current_user(wkz)
      post :create, leader_id: wkz.id
      expect(Relationship.count).to eq(0)      
    end

    it "redirects to leader page " do
    end

  end

  describe "DELETE destroy" do
    it "redirects to people page" do
      wkz = Fabricate(:user)
      set_current_user(wkz)
      wkm = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: wkz, leader: wkm)
      delete :destroy, id: relationship.id
      expect(response).to redirect_to people_path
    end

    it "deletes relationship if follower is following the leader" do
      wkz = Fabricate(:user)
      set_current_user(wkz)
      wkm = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: wkz, leader: wkm)
      delete :destroy, id: relationship.id
      expect(Relationship.count).to eq(0)
    end

    it "render people page if current user is not the follower" do
      wkz = Fabricate(:user)
      set_current_user(wkz)
      wkm = Fabricate(:user)
      wk = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: wk, leader: wkm)
      delete :destroy, id: relationship.id
      expect(Relationship.count).to eq(1)
    end
  end
end