class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews

    if @review.save
      flash[:notice] = "Thanks for the review!"
    else
      flash[:error] = @review.errors.full_messages.join(", ")
    end
    redirect_to item_path(@item)
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
