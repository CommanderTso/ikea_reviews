class VotesController < ApplicationController
  def upvote
    if user_signed_in?
      do_vote(vote_params, 1)
    else
      flash[:error] = "Please sign in to cast your vote!"
      redirect_to Review.find(vote_params).item
    end
  end

  def downvote
    if user_signed_in?
      do_vote(vote_params, -1)
    else
      flash[:error] = "Please sign in to cast your vote!"
      redirect_to Review.find(vote_params).item
    end
  end

  private

  def do_vote(vote_params, new_vote)
    @review = Review.find(vote_params)
    @user = current_user

    @vote = Vote.find_or_create_by(review: @review, user: @user)

    @vote.score = if @vote.score == new_vote
                    0
                  else
                    new_vote
                  end

    if @vote.save
      flash[:notification] = "Your vote has been cast!"
    else
      flash[:error] = @vote.errors.full_messages.join(", ")
    end
    redirect_to @review.item
  end

  def vote_params
    params.require(:review_id)
  end
end
