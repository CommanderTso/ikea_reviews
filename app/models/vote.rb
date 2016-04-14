class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :user, presence: true
  validates :review, presence: true
  validates :score, numericality: true, inclusion: { in: -1..1, message: "A vote must be -1, 0, or 1" }

  def change_vote(new_vote)
    self.score = if self.score == new_vote
                   0
                 else
                   new_vote
                 end
    self.save
    self.score
  end
end
