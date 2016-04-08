class Admins::ItemsController < ApplicationController
  before_filter :authorized?
  
  def index
    @items = Item.all
  end

  def destroy
    @item = Item.find(params[:id])
    Item.destroy(@item)
    redirect_to admins_items_path
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
