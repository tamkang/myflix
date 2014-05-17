require 'spec_helper'
describe QueueItem do
  it { should belong_to(:video) }
  it { should belong_to(:user) }
  it { should validate_numericality_of(:position).only_integer}

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

  describe "#rating=" do
    it "change the rating of the review if the rating is present" do
      wk = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, user: wk, video: video, rating: 1)
      queue_item = Fabricate(:queue_item, user: wk, video: video)
      queue_item.rating = 4
      expect(queue_item.rating).to eq(4)
    end
    it "clears the rating of the review if the rating is present" do
      wk = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, user: wk, video: video, rating: 1)
      queue_item = Fabricate(:queue_item, user: wk, video: video)
      queue_item.rating = nil
      expect(queue_item.rating).to eq(nil)
    end

    it "creates a review with  rating if the rating is not present" do
      wk = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: wk, video: video)
      queue_item.rating = 4
      expect(Review.first.rating).to eq(4)
    end
  end

end