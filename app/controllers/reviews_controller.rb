class ReviewsController < ApplicationController
  before_filter :find_item, only: [:create, :edit, :update, :destroy]

  def create
    @review = @item.reviews.build(review_params)
    if @review.save
      flash[:notice] = "Thanks for the review!"
    else
      flash[:error] = @review.errors.full_messages.join(", ")
    end
    redirect_to item_path(@item)
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.user == current_user
      @review.destroy
    end
    redirect_to item_path(@item)
  end

  def edit
    @review = Review.find(params[:id])
    @rating_options = Review::RATING_OPTIONS
    unless current_user == @review.user
      flash[:error] = "You are not authorized to view this page!"
      redirect_to root_path
    end
  end

  def update
    @review = Review.find(params[:id])
    @rating_options = Review::RATING_OPTIONS
    if @review.update(review_params)
      flash[:notice] = "Review updated successfully!"
      redirect_to item_path(@item)
    else
      flash[:error] = @review.errors.full_messages.join(", ")
      render 'edit'
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    ).merge(
      user_id: current_user.id
    )
  end

  def find_item
    @item = Item.find(params[:item_id])
  end
end
