class Item < ActiveRecord::Base
  validates :title, presence: true
  validates :subtitle, presence: true
  validates_uniqueness_of :item_url

  def price
    sprintf('%.2f', read_attribute(:price))
  end

  def self.search(query)
    where{ title =~ "#{query}%" }
  end
end
