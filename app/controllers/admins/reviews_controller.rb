class Admins::ReviewsController < AdminsController
  def index
    @items = Item.all
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admins_reviews_path
  end
end
