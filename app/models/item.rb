class Item < ActiveRecord::Base
		validates :title, presence: true
		validates :subtitle, presence: true

		def price
			sprintf('%.2f', read_attribute(:price))
		end
end
