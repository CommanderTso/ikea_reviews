class ItemsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new

    url = item_params[:item_url]

    if !validate_url(url)
      flash[:error] = "Please enter a valid Ikea product URL!"
      render :new and return
    end

    create_item(@item, url, item_params)

    if @item.save
      flash[:notice] = "Thanks for adding a new item to the site!"
      redirect_to @item
    elsif item_already_exists?
      original_item = Item.find_by(item_url: @item.item_url)
      redirect_to original_item
    else
      flash[:errors] = @item.errors.full_messages.join(", ")
      redirect_to new_item_path
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:item_url)
  end

  private

  def create_item(item, url, item_params)
    item_values = scrape_with_url(url)
    item.item_url = item_params[:item_url]
    item.title = item_values[:title]
    item.subtitle = item_values[:subtitle]
    item.picture_url = item_values[:picture_url]
    item.price =  item_values[:price]
  end

  def validate_url(raw_url)
    ikea_regexp = /(^(http:\/\/)?www.ikea.com\/us\/en\/catalog\/products\/[A-z0-9]{3,10}\/$)/
    return false if raw_url.match(ikea_regexp).nil?
    url = URI(raw_url)
    res = Net::HTTP.get_response(url)
    return false if res.code != "200"
    true
  end

  def scrape_with_url(raw_url)
    url = URI(raw_url)
    raw_page = Net::HTTP.get(url)
    parsed_page = Nokogiri::HTML(raw_page)

    return_hash = {}

    return_hash[:title] = parsed_page.xpath('//div[@id="name"]').text.strip
    return_hash[:subtitle] = parsed_page.xpath('//div[@id="type"]').text.strip
    return_hash[:picture_url] = "http://www.ikea.com#{parsed_page.xpath('//img[@id="productImg"]//@src').text}"
    return_hash[:price] = parsed_page.xpath('//head//meta[@name="price"]//@content').text.delete("$")

    return_hash
  end

  def item_already_exists?
    @item.errors[:item_url][0] == "has already been taken"
  end

  protected
  def authorize_user
    if !user_signed_in?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
