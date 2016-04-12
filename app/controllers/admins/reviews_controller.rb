class Admins::ReviewsController < ApplicationController
  before_filter :authorized?

  def index
    @items = Item.all
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admins_reviews_path
  end

  private

  def authorized?
    if current_user == nil
      flash[:error] = "Please sign in!"
      redirect_to root_path
    elsif current_user.role != "admin"
      flash[:error] = "You are not authorized to view that page."
      redirect_to root_path
    end
  end
end
