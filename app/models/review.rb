class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validates :rating, presence: true, numericality: true, inclusion: { in: 1..5, message: 'must be between 1-5' }

  RATING_OPTIONS = [
    ["Pick a Rating".freeze, 0],
    ["5 - Amazing".freeze, 5],
    ["4 - Great".freeze, 4],
    ["3 - Mediocre".freeze, 3],
    ["2 - Bad".freeze, 2],
    ["1 - Awful".freeze, 1]
  ].freeze
end
