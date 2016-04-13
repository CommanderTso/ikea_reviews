class VotesController < ApplicationController
  def upvote
    @review = Review.find(vote_params)
    @user = current_user

    @vote = Vote.find_or_create_by(review: @review, user: @user)

    if @vote.score == 1 then @vote.score = 0 else @vote.score = 1 end

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
