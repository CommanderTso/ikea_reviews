class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @items = @category.items.order(:title).page(params[:page])
  end
end
