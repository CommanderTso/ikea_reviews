class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new

    url = item_params[:item_url]

    if !validate_url(url)
      flash[:error] = "Please enter a valid Ikea product URL or Article Number!"
      render :new && return
    end

    create_item(@item, url, item_params)

    if @item.save
      flash[:notice] = "Here's your item!"
      redirect_to @item
    elsif @item.errors[:item_url][0] == "has already been taken"
      original_item = Item.find_by(item_url: @item.item_url)
      redirect_to original_item
    else
      # This is here to catch unknown errors so they can be handled better
      raise StandardError, "Unhandled invalid data in item creation request!"
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
    item.price = item_values[:price]
  end

  def validate_url(raw_url)
    # make sure proper format and ikea site
    if raw_url.match(/(^(http:\/\/)?www.ikea.com\/us\/en\/catalog\/products\/[A-z0-9]{3,10}\/$)/) == nil then return false end
    # make sure we get a 200 response to the url
    url = URI(raw_url)
    res = Net::HTTP.get_response(url)
    if res.code != "200" then return false end
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
end
