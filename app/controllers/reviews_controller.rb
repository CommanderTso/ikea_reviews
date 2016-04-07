class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @item = Item.find(params[:item_id])

    if @review.save
      flash[:notice] = "Thanks for the review!"
      redirect_to item_path(@review.item)
    else
      flash[:error] = @review.errors.full_messages.join(", ")
      redirect_to item_path(@item)
    end
  end

  private
  
  def review_params
    params.require(:review).permit(
      :rating,
      :description
    ).merge(
      item: Item.find(params[:item_id]),
      user: User.find(current_user)
    )
  end
end
