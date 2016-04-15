require 'rails_helper'

describe Vote do

  describe "#change_vote" do
    it "turns a current vote of 0 into 1 on upvote" do
      vote = create(:vote)

      expect(vote.change_vote(1)).to eq(1)
    end

    it "turns a current vote of 1 into 0 on upvote" do
      vote = create(:upvote)

      expect(vote.change_vote(1)).to eq(0)

    end

    it "turns a current vote of -1 into 1 on upvote" do
      vote = create(:downvote)

      expect(vote.change_vote(1)).to eq(1)

    end

    it "turns a current vote of 0 into -1 on downvote" do
      vote = create(:vote)

      expect(vote.change_vote(-1)).to eq(-1)

    end

    it "turns a current vote of 1 into -1 on downvote" do
      vote = create(:upvote)

      expect(vote.change_vote(-1)).to eq(-1)

    end

    it "turns a current vote of -1 into 0 on downvote" do
      vote = create(:downvote)

      expect(vote.change_vote(-1)).to eq(0)

    end
  end
end
