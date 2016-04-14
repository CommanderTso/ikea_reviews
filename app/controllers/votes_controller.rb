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

  def ajax_upvote
    if user_signed_in?
      do_vote(vote_params, 1, true)
    else
      render json: { 'login_error' => "Please sign in to cast your vote!" }
    end
  end

  def ajax_downvote
    if user_signed_in?
      do_vote(vote_params, -1, true)
    else
      render json: { 'login_error' => "Please sign in to cast your vote!" }
    end
  end

  private

  def json_please_sign_in

  end

  def do_vote(vote_params, new_vote, sendJson = false)
    @review = Review.find(vote_params)
    @user = current_user

    @vote = Vote.find_or_create_by(review: @review, user: @user)

    @vote.change_vote(new_vote)

    if sendJson == false
      resolve_with_http(@vote, @review)
    else
      resolve_with_json(@vote, @review)
    end
  end

  def resolve_with_http(vote, review)
    flash[:notification] = "Your vote has been cast!"
    redirect_to review.item
  end

  def resolve_with_json(vote, review)
    render json: {
      'new_score' => Review.find(vote_params).net_rating,
      'review_id' => review.id
    }
  end

  def vote_params
    params.require(:review_id)
  end
end
