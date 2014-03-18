require 'spec_helper'
describe QueueItem do
  it { should belong_to(:video) }
  it { should belong_to(:user) }

  describe "#rating" do
  	it "returns the rating from the review when the review is present" do
	  wk = Fabricate(:user)
	  video = Fabricate(:video)
	  review = Fabricate(:review, user: wk, video: video, rating: 4)
	  queue_item = Fabricate(:queue_item, user: wk, video: video)
	  expect(queue_item.rating).to eq(4)
    end

    it "returns nil when review is not present" do
      wk = Fabricate(:user)
	  video = Fabricate(:video)
	  queue_item = Fabricate(:queue_item, user: wk, video: video)
	  expect(queue_item.rating).to eq(nil)
    end
  end
end