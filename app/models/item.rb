class Item < ActiveRecord::Base
  has_many :reviews
  belongs_to :category

  validates :title, presence: true
  validates :subtitle, presence: true
  validates :category, presence: true
  validates_uniqueness_of :item_url

  def price
    sprintf('%.2f', read_attribute(:price))
  end

  def calculate_average_review_score
    rating_sum = reviews.inject(0) { |sum, review| sum + review.rating }
    (rating_sum.to_f / reviews.count).round(2)
  end
end
