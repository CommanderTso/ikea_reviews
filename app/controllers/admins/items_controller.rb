class Admins::ItemsController < AdminsController
  def index
    @items = Item.all
  end

  def destroy
    @item = Item.find(params[:id])
    flash[:notice] = "#{@item.title} has been deleted!"
    @item.destroy
    redirect_to admins_items_path
  end
end
