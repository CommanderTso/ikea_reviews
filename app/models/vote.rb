class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :user, presence: true
  validates :review, presence: true
  validates :score, numericality: true, inclusion: { in: -1..1, message: "A vote must be -1, 0, or 1" }
end
