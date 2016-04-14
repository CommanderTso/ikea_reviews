class ItemsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
  helper_method :user_reviewed?

  def index
    if !params.has_key?(:search)
      @items = Item.order(:title).page(params[:page])
    elsif params[:search] == ""
      flash[:error] = "Please enter a search term to search for products!"
      @items = Item.order(:title).page(params[:page])
    else
      @items = Item.search(params[:search]).order(:title).page(params[:page])
    end
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
      flash[:notice] = "We've already got that one!  Here you go:"
      redirect_to original_item
    end
  end

  def show
    @item = Item.find(params[:id])
    @review = Review.new
    @reviews = @item.reviews.order(created_at: :desc).page(params[:page])
    @rating_options = Review::RATING_OPTIONS

    @headline = set_show_headline(@item, @reviews.count)
  end

  def item_params
    params.require(:item).permit(:item_url)
  end

  private

  def user_reviewed?
    @reviews = @item.reviews.order(created_at: :desc).page(params[:page])
    @users_who_reviewed = []

    @reviews.each do |review|
      @users_who_reviewed << review.user
    end

    @users_who_reviewed.include?(current_user)
  end

  def set_show_headline(item, review_count)
    headline = "Reviews"
    if review_count > 0
      headline += " - Average Review Score: #{item.calculate_average_review_score}"
    end
    headline
  end

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

  def authorize_user
    if !user_signed_in?
      flash[:notice] = "Please sign up to add a new item!"
      redirect_to new_user_registration_path
    end
  end
end
