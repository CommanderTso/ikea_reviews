class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validates :rating, presence: true, numericality: true, inclusion: { in: 1..5, message: 'must be between 1-5' }

  RATING_OPTIONS = [
    ["Pick a Rating", 0],
    ["5 - Amazing", 5],
    ["4 - Great", 4],
    ["3 - Mediocre", 3],
    ["2 - Bad", 2],
    ["1 - Awful", 1]
  ]
end
