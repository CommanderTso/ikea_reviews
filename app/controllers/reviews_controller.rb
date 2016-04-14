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

  def destroy
    @review = Review.find(params[:item_id])
    @item = @review.item
    if @review.user == current_user
      @review.destroy
    end
    redirect_to item_path(@item)
  end

  def edit
    @review = Review.find(params[:review_id])
    @item = Item.find(@review.item.id)
    if current_user == @review.user
      @rating_options = Review::RATING_OPTIONS
    else
      flash[:error] = "You are not authorized to view this page!"
      redirect_to root_path
    end
  end

  def update
    @review = Review.find(params[:id])
    @item = @review.item
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
      item_id: params[:item_id],
      user_id: current_user.id
    )
  end
end
