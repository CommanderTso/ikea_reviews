class Item < ActiveRecord::Base
  has_many :reviews

  validates :title, presence: true
  validates :subtitle, presence: true
  validates_uniqueness_of :item_url

  def price
    sprintf('%.2f', read_attribute(:price))
  end

  def calculate_average_review_score
    rating_sum = reviews.inject(0) { |sum, review| sum + review.rating }
    rating_count = reviews.count
    (rating_sum.to_f / rating_count).round(2)
  end
end
