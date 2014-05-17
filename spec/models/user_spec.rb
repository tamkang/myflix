require 'spec_helper'

describe User do
  it { should have_secure_password}
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:reviews) }
  it { should have_many(:queue_items) }

  describe "#follows?" do
  	it "returns true if the user has a following relationship with another user" do
  	  wkz = Fabricate(:user)
  	  wkm = Fabricate(:user)
  	  relationship = Fabricate(:relationship, follower: wkz, leader: wkm)
  	  expect(wkz.follows?(wkm)).to be_truthy
  	end
  	it "returns false  if the user doesnt have a following relationship with another user" do
  	  wk = Fabricate(:user)
  	  wkz = Fabricate(:user) 	 
  	  wkm = Fabricate(:user)
  	  relationship = Fabricate(:relationship, follower: wkz, leader: wk)
  	  expect(wkz.follows?(wkm)).to be_falsey
  	end
  end
end
