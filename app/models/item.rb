class Item < ActiveRecord::Base
  has_many :reviews

  validates :title, presence: true
  validates :subtitle, presence: true
  validates_uniqueness_of :item_url

  def price
    sprintf('%.2f', read_attribute(:price))
  end
end
