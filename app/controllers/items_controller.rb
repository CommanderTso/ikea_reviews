require 'net/http'
require 'uri'

class ItemsController < ApplicationController

	def new
		@item = Item.new
	end

	def create
		@item = Item.new(item_params)

		if !@item.item_url.empty?
			item_values = scrape_with_url(@item.item_url)
		else

		end

		@item.title =  item_values[:title]
		@item.subtitle =  item_values[:subtitle]
		@item.picture_url =  item_values[:picture_url]
		@item.price =  item_values[:price]

		if @item.save
			flash[:notice] = "Here's your item!"
			redirect_to @item
		else
			flash[:error] = @item.errors.full_messages.join("\n")
			render :new
		end

	end

	def show
		@item = Item.find(params[:id])
	end

	def item_params
		params.require(:item).permit(:item_url)
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
