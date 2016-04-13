describe Review do
  describe "#net_rating" do
    it "returns the net of all the review's up and down votes" do
      item = create(:item)
      review = create(:review, item: item)
      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)
      create(:upvote, review: review, user: user_1)
      create(:upvote, review: review, user: user_2)
      create(:downvote, review: review, user: user_3)

      expect(review.net_rating).to eq(1)
    end
  end
end
