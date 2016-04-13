class Admins::ItemsController < AdminsController
  def index
    @items = Item.all
  end

  def destroy
    @item = Item.find(params[:id])
    if current_user.role = "admin"
      @item.destroy
    else
      flash[:notice] = "You are not authorized to do that!"
    end
    redirect_to admins_items_path
end
